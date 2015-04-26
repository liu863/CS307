//
//  CourseViewViewController.m
//  PurdueCourseAssistant
//
//  Created by Ransen on 3/2/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "CourseViewViewController.h"
#import "Course.h"
#import "ServerInfo.h"
@interface CourseViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *tag2;
@property (weak, nonatomic) IBOutlet UILabel *tag3;
@property (strong, nonatomic) NSString *coursename;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UITextView *CourseD;
@property (weak, nonatomic) IBOutlet UITextView *Comment;

@end
CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

NSString * s;
@implementation CourseViewViewController


- (IBAction)showCourse:(id)sender{
    [self.CourseD setHidden:NO];
    [self.Comment setHidden:YES];
}

- (IBAction)showComment:(id)sender{
    [self.CourseD setHidden:YES];
    [self.Comment setHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.CourseD setHidden:NO];
    [self.Comment setHidden:YES];
    // Do any additional setup after loading the view.
    [self initNetworkCommunication];
    NSString *sendR = [NSString stringWithFormat:@"getcinf|%@",  course.courseName];

    [self sendRequest: sendR];//need course name!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self viewDidLoad];
    // Reload your data here, and this gets called
    // before the view transition is complete.
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
                NSLog(@"asasdasd");
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
                    
                    NSString * new = respond[2];
                    
                    NSInteger b = [new integerValue]%10;
                    //course.courseRating = [NSNumber numberWithInteger:b];
                    //NSLog(@"Respo received: %d", b);
                    if (b == 0)
                    {
                        self.rate.text =[NSString stringWithFormat:@"0.%d",  0];
                    }
                    else{
                        if (b >= 60)
                        {
                            self.rate.text = [NSString stringWithFormat:@"0.%c",  [new characterAtIndex:1]];
                        }
                        else
                        {
                            self.rate.text = [NSString stringWithFormat:@"%c.%c", [new characterAtIndex:0],[new characterAtIndex:1]];
                        }
                    }
                    
                    self.CourseD.text = respond[3];
                    course.courseDescription = respond[3];
                    NSString *tads = respond[4];
                    course.courseTag = respond[4];
                    char *array[10] = {"Easy", "Hard", "Group", "Solo", "Tedious", "Funny", "Useful", "Lab", "Busy", "Serious"};
                    NSLog(@"%s\n", array[1]);
                    if([tads length] != 0){
                        char y1 = [tads characterAtIndex:0];
                        int x1 = (int)(y1 - '0');
                        self.tag1.text = [NSString stringWithFormat:@"%s",  array[x1]];
                        NSLog(@"tag = 0, Respo received: %@", self.rate.text);
                        char y2 = [tads characterAtIndex:1];
                        int x2 = (int)(y2 - '0');
                        self.tag2.text = [NSString stringWithFormat:@"%s",  array[x2]];
                        char y3 = [tads characterAtIndex:2];
                        int x3 = (int)(y3 - '0');
                        self.tag3.text = [NSString stringWithFormat:@"%s",  array[x3]];
                    }
                    else{
                        self.tag1.text = @"Easy";
                        NSLog(@"tag != 0, Respo received: %@", self.rate.text);
                        self.tag2.text = @"Solo";
                        
                        self.tag3.text = @"Funny";
                    }
                    int length = [respond count];
                    NSLog(@" conut %d", length);
                    int tmp = 7;
                    if(length >= 7){
                        self.Comment.text = respond[6];
                        course.courseComment = respond[6];
                        NSLog(@" conut %d", length);
                        while(tmp < length)
                        {
                            NSLog(@"%@\n", respond[tmp]);
                            NSLog(@"asdasdas");
                            self.Comment.text = [NSString stringWithFormat:@"%@\n%@", self.Comment.text, respond[tmp]];
                            NSLog(@"asdasda11s");
                            tmp++;
                        }
                        NSLog(@"Respo received: %@", self.Comment.text);
                    }
                    else {
                        [course.courseComment addObject:@" "];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end