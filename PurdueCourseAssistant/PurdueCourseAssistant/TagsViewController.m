//
//  TagsViewController.m
//  PurdueCourseAssistant
//
//  Created by w23html on 3/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "TagsViewController.h"
#import "ServerInfo.h"
#import "Course.h"
#import "User.h"


@interface TagsViewController ()

@end

@implementation TagsViewController

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;

static int tags[10];
static int count;
static int perform;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    count = 0;
    perform = 0;
    for (int i = 0; i < 10; i++) {
        tags[i] = 0;
    }
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendTagRequest {
    NSString * courselist_tags = @"";
    if (count == 3) {
        [self initNetworkCommunication];
        
        for (int i = 0; i < 10; i++) {
            if (tags[i] == 1) {
                courselist_tags = [courselist_tags stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
            }
        }
        course.tags = [NSString stringWithString: courselist_tags];
        
        // Send the request list to server
        NSString * tags_send = [NSString stringWithFormat:@"getclst|%@", courselist_tags];
        NSLog(@"%@", tags_send);
        
        [self sendRequest:tags_send];
    }
}

- (IBAction)goPressed:(id)sender {
    NSString * courselist_tags = @"";
    if (count != 3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You can not choose more or less than 3 tags!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag1 setBackgroundColor:lightblue];
        [_tag2 setBackgroundColor:lightblue];
        [_tag3 setBackgroundColor:lightblue];
        [_tag4 setBackgroundColor:lightblue];
        [_tag5 setBackgroundColor:lightblue];
        [_tag6 setBackgroundColor:lightblue];
        [_tag7 setBackgroundColor:lightblue];
        [_tag8 setBackgroundColor:lightblue];
        [_tag9 setBackgroundColor:lightblue];
        [_tag10 setBackgroundColor:lightblue];
        perform = 0;
    }
    else {
        UIColor * lightblue = [[UIColor alloc] initWithRed:0.63970924949999997 green:0.91012415170000005 blue:1 alpha:1];
        [_tag1 setBackgroundColor:lightblue];
        [_tag2 setBackgroundColor:lightblue];
        [_tag3 setBackgroundColor:lightblue];
        [_tag4 setBackgroundColor:lightblue];
        [_tag5 setBackgroundColor:lightblue];
        [_tag6 setBackgroundColor:lightblue];
        [_tag7 setBackgroundColor:lightblue];
        [_tag8 setBackgroundColor:lightblue];
        [_tag9 setBackgroundColor:lightblue];
        [_tag10 setBackgroundColor:lightblue];
        perform = 1;
    }
    count = 0;
    for (int i = 0; i < 10; i++) {
        tags[i] = 0;
    }
    NSLog(@"global tags %@", course.tags);
    sleep(1);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqual:@"go"] && perform == 1) {
        return YES;
    }
    return NO;
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
    NSLog(@"this is 0 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 1 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 2 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 3 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 4 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 5 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 6 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 7 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 8 count:%d", count);
    [self sendTagRequest];
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
    NSLog(@"this is 9 count:%d", count);
    [self sendTagRequest];
}

- (void)initNetworkCommunication {
    ServerInfo * server = [[ServerInfo alloc] init];
    CFStringRef hostAddress = (__bridge CFStringRef)server.hostAddress;
    int port = [server.port intValue];
    // NSLog(@"host = %@, port = %d", hostAddress, port);
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
                NSLog(@"Output Stream\n");
            }
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"flag 0");
            if(stream == inputStream) {
                NSLog(@"flag 1");
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
                    
                    //NSArray * respond = [s componentsSeparatedByString:@"|"];
                    
                    course.courseList = s;
                    
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
