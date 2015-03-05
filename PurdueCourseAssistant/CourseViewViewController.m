//
//  CourseViewViewController.m
//  PurdueCourseAssistant
//
//  Created by Ransen on 3/2/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "CourseViewViewController.h"
#import "Course.h"
@interface CourseViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *tag2;
@property (weak, nonatomic) IBOutlet UILabel *tag3;

@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *CourseD;
@property (weak, nonatomic) IBOutlet UILabel *Comment;

@end

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
  Course *course1 = [[Course alloc] init];
  course1.courseName = @"CS308";
  course1.courseDescription = @"asd";
  course1.courseTag = @"123";
  course1.courseRating = [[NSNumber alloc] initWithFloat: 1.1];
  course1.courseComment = @[@"good", @"bad"];
  
  [self.CourseD setHidden:NO];
  [self.Comment setHidden:YES];
  NSString * newString = course1.courseTag;
  NSString * new = [newString substringWithRange:NSMakeRange(0, 1)];
  self.tag1.text = new;
  NSString * new1 = [newString substringWithRange:NSMakeRange(1, 1)];
  self.tag2.text = new1;
  NSString * new2 = [newString substringWithRange:NSMakeRange(2,1)];
  self.tag3.text = new2;
  NSString * tmp = [NSString stringWithFormat:@"%@/5.0", course1.courseRating];
  self.rate.text = tmp;
  [self.CourseD setText:course1.courseDescription];
  NSString * result = [[course1.courseComment valueForKey:@"description"] componentsJoinedByString:@""];
  [self.Comment setText:result];
  
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

@end
