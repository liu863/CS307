//
//  MyInfoViewController.m
//  Start
//
//  Created by ZhengshangLiu on 15/3/4.
//  Copyright (c) 2015年 ZhengshangLiu. All rights reserved.
//

#import "MyInfoViewController.h"
#import "ServerInfo.h"

@interface MyInfoViewController ()

@end

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNetworkCommunication];
    [self sendRequest: @"getuinf|aa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***************************************************/
// Client Implementation
/***************************************************/

- (void)initNetworkCommunication {
    ServerInfo * server = [[ServerInfo alloc] init];
    CFStringRef hostAddress = (__bridge CFStringRef)server.hostAddress;
    int port = [server.port intValue];
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, hostAddress, port, &readStream, &writeStream);
    if(!CFWriteStreamOpen(writeStream)) {
        NSLog(@"Error: writeStream");
        return;
    }
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}


-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasSpaceAvailable: {
            if(stream == outputStream){
                NSLog(@"none\n");
            }
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            if(stream == inputStream) {
                uint8_t buf[1024];
                unsigned int len = 0;
                len = [inputStream read:buf maxLength:1024];
                if(len > 0) {
                    NSMutableData* data=[[NSMutableData alloc] initWithLength:0];
                    [data appendBytes: (const void *)buf length:len];
                    s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    
                    /***************************************************/
                    // Process Server Respond
                    /***************************************************/
                    NSLog(@"Respond received: %@", s);
                    NSArray * respond = [s componentsSeparatedByString:@"|"];
                    _Name.text = respond[3];
                    _Emailaddr.text = respond[2];
                    _Courses.text = respond[4];
                    
                    
                    /***************************************************/
                    // End
                    /***************************************************/
                    
                }
            }
            break;
        }
        case NSStreamEventEndEncountered: {
            NSLog(@"Stream closed\n");
            break;
        }
        default: {
            NSLog(@"Stream is sending an Event: %lu", eventCode);
            break;
        }
    }
}

-(void)sendRequest: (NSString *) request{
    NSData *data = [[NSData alloc] initWithData:[request dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    [outputStream close];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
