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
@property (weak, nonatomic) IBOutlet UILabel *CourseD;
@property (weak, nonatomic) IBOutlet UILabel *Comment;

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
  
  /*
  Course *course1 = [[Course alloc] init];
  course1.courseName = @"CS308";
  course1.courseDescription = @"The course gives a broad introduction to the design and analysis of algorithms.  The course strives to strengthen a student’s ability to solve problems computationally by effectively utilizing an understanding of algorithm design techniques, algorithms analysis, and data structures. ";
  course1.courseTag = @"123";
  course1.courseRating = [[NSNumber alloc] initWithFloat: 4.2];
  course1.courseComment = @[@"Tom: This course is very helpful!\n", @"James: Course load is pretty heavy, it would be better to take this course in the first two years.\n"];
  
  [self.CourseD setHidden:NO];
  [self.Comment setHidden:YES];
  NSString * newString = course1.courseTag;
  NSString * new = [newString substringWithRange:NSMakeRange(0, 1)];
    if([new isEqualToString: @"1"]){
        new = @"Easy";
    }
  self.tag1.text = new;
  NSString * new1 = [newString substringWithRange:NSMakeRange(1, 1)];
    if([new1 isEqualToString: @"2"]){
        new1 = @"Helpful";
    }
  self.tag2.text = new1;
  NSString * new2 = [newString substringWithRange:NSMakeRange(2,1)];
    if([new2 isEqualToString: @"3"]){
        new2 = @"Heavy Workload";
    }
  self.tag3.text = new2;
  NSString * tmp = [NSString stringWithFormat:@"%@/5.0", course1.courseRating];
  self.rate.text = tmp;
  [self.CourseD setText:course1.courseDescription];
    _CourseD.numberOfLines = 0;
    [_CourseD sizeToFit];
  NSString * result = [[course1.courseComment valueForKey:@"description"] componentsJoinedByString:@""];
  [self.Comment setText:result];
    _Comment.numberOfLines = 0;
    [_Comment sizeToFit];
  */
  // Do any additional setup after loading the view.
  [self initNetworkCommunication];
  [self sendRequest: @"getcinf|CS307"];//need course name!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
          NSLog(@"Respond received: %@", s);
          NSArray * respond = [s componentsSeparatedByString:@"|"];
          
          NSString * new = respond[2];
          
          NSInteger b = [new integerValue];
          NSLog(@"Respo received: %d", b);
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
          NSString *tads = respond[4];
          self.tag1.text = [NSString stringWithFormat:@"%c",  [tads characterAtIndex:1]];
          NSLog(@"Respo received: %@", self.rate.text);
          self.tag2.text = [NSString stringWithFormat:@"%c",  [tads characterAtIndex:1]];
          self.tag3.text = [NSString stringWithFormat:@"%c",  [tads characterAtIndex:1]];
          self.Comment.text = respond[5];
           NSLog(@"Respo received: %@", self.rate.text);
          
          
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
