//
//  FeedbackViewController.m
//  Sec
//
//  Created by w23html on 2/28/15.
//  Copyright (c) 2015 w23html. All rights reserved.
//

#import "FeedbackViewController.h"
#import "ServerInfo.h"
#import "Course.h"
#import "User.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;

static int tag[10];

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 10; i++) {
        tag[i] = 0;
    }
    [_score setText:@"4.0/5.0"];
    [_tag1 setTitle:@"Easy" forState:UIControlStateNormal];
    [_tag2 setTitle:@"Hard" forState:UIControlStateNormal];
    [_tag3 setTitle:@"Group" forState:UIControlStateNormal];
    [_tag4 setTitle:@"Solo" forState:UIControlStateNormal];
    [_tag5 setTitle:@"Tedious" forState:UIControlStateNormal];
    [_tag6 setTitle:@"Funny" forState:UIControlStateNormal];
    [_tag7 setTitle:@"Useful" forState:UIControlStateNormal];
    [_tag8 setTitle:@"Lab" forState:UIControlStateNormal];
    [_tag9 setTitle:@"Busy" forState:UIControlStateNormal];
    [_tag10 setTitle:@"Serious" forState:UIControlStateNormal];
    
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

- (IBAction)sliderChanged:(id)sender {
    NSString *ratingString = [[NSString alloc] initWithFormat:@"%1.1f/5.0", [_slider value]];
    [_score setText:ratingString];
}

- (IBAction)buttonPressed:(id)sender {
    
    int fake_rating = [_slider value] * 10;
    if ( fake_rating < 10 ) {
        fake_rating = fake_rating + 60;
    }
    NSString * feedback_rating = [NSString stringWithFormat:@"%d", fake_rating];
    
    NSString * feedback_tags = @"";
    int i = 0;
    while (i < 10) {
        if (tag[i] == 1)
            feedback_tags = [feedback_tags stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        i++;
    }
    
    NSString * feedback_send = [NSString stringWithFormat:@"comment|%@|%@|%@|%@|%@", user.user_id,course.courseName, feedback_rating, feedback_tags, [_comment text]];
    NSLog(@"%@", feedback_send);
    
    [self initNetworkCommunication];
    
    [self sendRequest: feedback_send];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Thanks for your feedback!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    for (int i = 0; i < 10; i++) {
        tag[i] = 0;
    }
}


- (IBAction)tag1Pressed:(id)sender {
    if (tag[0] == 0) {
        tag[0] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag1 setBackgroundColor:purple];
    } else {
        tag[0] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag1 setBackgroundColor:lightblue];
    }
}

- (IBAction)tag2Pressed:(id)sender {
    if (tag[1] == 0) {
        tag[1] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag2 setBackgroundColor:purple];
    } else {
        tag[1] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag2 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag3Pressed:(id)sender {
    if (tag[2] == 0) {
        tag[2] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag3 setBackgroundColor:purple];
    } else {
        tag[2] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag3 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag4Pressed:(id)sender {
    if (tag[3] == 0) {
        tag[3] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag4 setBackgroundColor:purple];
    } else {
        tag[3] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag4 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag5Pressed:(id)sender {
    if (tag[4] == 0) {
        tag[4] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag5 setBackgroundColor:purple];
    } else {
        tag[4] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag5 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag6Pressed:(id)sender {
    if (tag[5] == 0) {
        tag[5] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag6 setBackgroundColor:purple];
    } else {
        tag[5] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag6 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag7Pressed:(id)sender {
    if (tag[6] == 0) {
        tag[6] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag7 setBackgroundColor:purple];
    } else {
        tag[6] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag7 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag8Pressed:(id)sender {
    if (tag[7] == 0) {
        tag[7] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag8 setBackgroundColor:purple];
    } else {
        tag[7] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag8 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag9Pressed:(id)sender {
    if (tag[8] == 0) {
        tag[8] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag9 setBackgroundColor:purple];
    } else {
        tag[8] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag9 setBackgroundColor:lightblue];
    }
}
- (IBAction)tag10Pressed:(id)sender {
    if (tag[9] == 0) {
        tag[9] = 1;
        UIColor * purple = [[UIColor alloc] initWithRed:0.76574755333434186 green:0.55948865053223462 blue:1 alpha:1];
        [_tag10 setBackgroundColor:purple];
    } else {
        tag[9] = 0;
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag10 setBackgroundColor:lightblue];
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

@end
