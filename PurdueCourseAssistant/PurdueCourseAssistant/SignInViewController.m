///
//  SignInViewController.m
//  pudu
//
//  Created by Danny on 3/4/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import "SignInViewController.h"
#import "ServerInfo.h"
#import "User.h"
#import  "Course.h"
@interface SignInViewController ()


@end

@implementation SignInViewController

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString *Username;
NSString *Password;
NSString *s;
static int perform;
- (void)viewDidLoad {
    [super viewDidLoad];
    course = [[Course alloc] init];
    user = [[User alloc] init];
    
    _password.secureTextEntry = true;
    
    [self initNetworkCommunication];    // Do any additional setup after loading the view.
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
                       // perform =1;
                        user = [[User alloc] init];
                        course = [[Course alloc] init];
                        user.user_id = Username;
                        course.courseName = @"CS307";
                        //[self performSegueWithIdentifier:@"LoginSegue" sender:self];
                        
                    }else{
                        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Wrong Password or Invaild Username." delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
                        [alert show];
                        
                    }
                    
                    //NSArray * respond = [s componentsSeparatedByString:@"|"];
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




- (IBAction)login:(id)sender {
    Username = [_username text];
    Password = [_password text];
    if ([_username.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in username" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
        perform = 0;
    }else if([_password.text length] == 0){
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
        perform = 0;
    }else{
        NSString *r = [NSString stringWithFormat:@"loginur|%@|%@\0",Username,Password];
        user.user_id = Username;
        [self sendRequest: r];
        NSLog(@"Respond received: %@",s);
        perform =1;
        // if ([ s isEqualToString: @"SUCCESS\n"]) {
        //    user = [[User alloc] init];
        //    course = [[Course alloc] init];
        //   user.user_id = Username;
        
        
        //    }
        NSLog(@"%@", Username);
        NSLog(@"%@", Password);
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqual:@"LoginSegue"] && perform == 1) {
        //perform = 0;
        return YES;
        // perform = 0;
    }else if([identifier isEqual:@"SignUpSegue"]){
        perform =0;
        return YES;
    }else if([identifier isEqual:@"ResetSegue"]){
        perform = 0;
        return YES;
        
    }
    
    
    return NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
