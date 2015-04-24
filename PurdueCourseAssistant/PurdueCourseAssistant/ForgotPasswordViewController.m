//
//  ForgotPasswordViewController.m
//  pudu
//
//  Created by Danny on 3/4/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ServerInfo.h"
@interface ForgotPasswordViewController ()

@end
CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;
NSString *email;
NSString *Username;
NSString * s;
@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
                    
                    if ( [s rangeOfString: @"SUCCESS"].location != NSNotFound ) {
                        
                        // perform = 1 ;
                        //[self performSegueWithIdentifier:@"LoginSegue" sender:self];
                        
                    }else{
                        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Invaild e-mail address" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
                        [alert show];
                        
                    }
                    
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
    NSString * tmp = [NSString stringWithFormat:@"%@\r\n", request];
    NSData *data = [[NSData alloc] initWithData:[tmp dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    [outputStream close];
}




- (IBAction)Email:(id)sender {
    
    NSString *email = [_Email text];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    if ([_Email.text length] == 0 ) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in E-MAIL" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([emailTest evaluateWithObject:_Email.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Successful" message:@"An e-mail have sent to you." delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
        NSString *r = [NSString stringWithFormat:@"resetpw|%@|%@\0",Username,email];
        [self sendRequest: r];
        NSLog(@"Respond received: %@",s);
        NSLog(@"%@", email);
        NSLog(@"%@", Username);

    }
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

@end
