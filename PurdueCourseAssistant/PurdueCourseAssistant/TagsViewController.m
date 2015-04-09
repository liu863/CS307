//
//  TagsViewController.m
//  PurdueCourseAssistant
//
//  Created by w23html on 3/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "TagsViewController.h"
#import "ServerInfo.h"


@interface TagsViewController ()

@end

@implementation TagsViewController

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;

int tags[10] = {0,0,0,0,0,0,0,0,0,0};
int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goPressed:(id)sender {
    if (count != 3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You can not choose more or less than 3 tags!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        NSString * courselist_tags = @"";

        for (int i = 0; i < 10; i++) {
            if (tags[i] == 1) {
                courselist_tags = [courselist_tags stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
            }
        }
        NSString * tags_send = [NSString stringWithFormat:@"getclst|%@", courselist_tags];
        NSLog(@"%@", tags_send);
        [self initNetworkCommunication];
        [self sendRequest: tags_send];
    }
}

- (IBAction)tag1Pressed:(id)sender {
    if (tags[0] == 0) {
        tags[0] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag1 setBackgroundColor:purple];
        count++;
    } else {
        tags[0] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag1 setBackgroundColor:lightblue];
        count--;
    }
}
- (IBAction)tag2Pressed:(id)sender {
    if (tags[1] == 0) {
        tags[1] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag2 setBackgroundColor:purple];
        count++;
    } else {
        tags[1] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag2 setBackgroundColor:lightblue];
        count--;
    }
}

- (IBAction)tag3Pressed:(id)sender {
    if (tags[2] == 0) {
        tags[2] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag3 setBackgroundColor:purple];
        count++;
    } else {
        tags[2] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag3 setBackgroundColor:lightblue];
        count--;
    }
}
- (IBAction)tag4Pressed:(id)sender {
    if (tags[3] == 0) {
        tags[3] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag4 setBackgroundColor:purple];
        count++;
    } else {
        tags[3] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag4 setBackgroundColor:lightblue];
        count--;
    }
}
- (IBAction)tag5Pressed:(id)sender {
    if (tags[4] == 0) {
        tags[4] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag5 setBackgroundColor:purple];
        count++;
    } else {
        tags[4] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag5 setBackgroundColor:lightblue];
        count--;
    }
}
- (IBAction)tag6Pressed:(id)sender {
    if (tags[5] == 0) {
        tags[5] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag6 setBackgroundColor:purple];
        count++;
    } else {
        tags[5] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag6 setBackgroundColor:lightblue];
        count--;
    }
}

- (IBAction)tag7Pressed:(id)sender {
    if (tags[6] == 0) {
        tags[6] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag7 setBackgroundColor:purple];
        count++;
    } else {
        tags[6] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag7 setBackgroundColor:lightblue];
        count--;
    }
}

- (IBAction)tag8Pressed:(id)sender {
    if (tags[7] == 0) {
        tags[7] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag8 setBackgroundColor:purple];
        count++;
    } else {
        tags[7] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag8 setBackgroundColor:lightblue];
        count--;
    }
}

- (IBAction)tag9Pressed:(id)sender {
    if (tags[8] == 0) {
        tags[8] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag9 setBackgroundColor:purple];
        count++;
    } else {
        tags[8] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag9 setBackgroundColor:lightblue];
        count--;
    }
}

- (IBAction)tag10:(id)sender {
    if (tags[9] == 0) {
        tags[9] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag10 setBackgroundColor:purple];
        count++;
    } else {
        tags[9] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag10 setBackgroundColor:lightblue];
        count--;
    }
}

- (void)initNetworkCommunication {
    ServerInfo * server = [[ServerInfo alloc] init];
    CFStringRef hostAddress = (__bridge CFStringRef)server.hostAddress;
    int port = [server.port intValue];
    NSLog(@"host = %@, port = %d", hostAddress, port);
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
    [outputStream open];
    [inputStream open];
    
    
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
                    NSLog(@"Respond received: %@", s);
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
    NSString * tmp = [NSString stringWithFormat:@"%@\r\n", request];
    NSData *data = [[NSData alloc] initWithData:[tmp dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    [outputStream close];
    [self initNetworkCommunication];
}

@end
