//
//  SignUpViewController.m
//  pudu
//
//  Created by Danny on 3/3/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import "SignUpViewController.h"
#import "ServerInfo.h"
#import "User.h"
#import  "Course.h"
@interface SignUpViewController ()





@end

@implementation SignUpViewController

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;
NSString *Username;
NSString *Password;
NSString *Repswd;
NSString *Email;
- (void)viewDidLoad {
    [super viewDidLoad];
    _Password.secureTextEntry = true;
    _rePassword.secureTextEntry = true;
    
    [self initNetworkCommunication];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                    //NSLog(@"Respond received: %@", s);
                    
                    NSArray * respond = [s componentsSeparatedByString:@"|"];
                    
                    if ( [s rangeOfString: @"UREXIST"].location != NSNotFound ) {
                        NSLog(@"flag 0");
                        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Username Existed ,Pleanse change another Username" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
                        [alert show];
                        
                        
                    }else{
                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:@"SUCCESS." delegate:self cancelButtonTitle: nil otherButtonTitles: @"OK", nil];
                        [alert show];
                    }
                    
                    // _Name.text = respond[3];
                    // _Emailaddr.text = respond[2];
                    // _Courses.text = respond[4];
                    
                    
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


- (IBAction)Signup:(id)sender {
    Username = [_Username text];
    Password = [_Password text];
    Repswd = [_rePassword text];
    Email = [_Email text];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([_Username.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in username" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_Password.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_rePassword.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please retype password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_Email.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in E-MAIL" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    } else if ([emailTest evaluateWithObject:_Email.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if ([_Password.text isEqualToString:_rePassword.text]) {
        NSString *r = [NSString stringWithFormat:@"createu|%@|%@|%@",Username,Password,Email];
        [self sendRequest: r];
        //   NSString *a = @"UREXIST";
        
        NSLog(@"%@", Username);
        NSLog(@"%@", Password);
        
        NSLog(@"%@", Repswd);
        NSLog(@"%@", Email);
        
    }else {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please type same password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }
}


-(void)sendRequest: (NSString *) request{
    NSString * tmp = [NSString stringWithFormat:@"%@\r\n", request];
    NSData *data = [[NSData alloc] initWithData:[tmp dataUsingEncoding:NSASCIIStringEncoding]];
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
