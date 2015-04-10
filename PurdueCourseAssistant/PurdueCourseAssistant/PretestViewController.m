//
//  PretestViewController.m
//  PreTest
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "PretestViewController.h"
#import "Question.h"
#import "Pretest.h"
#import "Course.h"

@interface PretestViewController ()

@end

@implementation PretestViewController{
    Pretest * thisTest;
    NSArray * questions;
    NSMutableArray * answers;
    int count, grade;
    NSUInteger length;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Load the test and initialize instence variables
    thisTest = [[Pretest alloc] initWithCourseTitle:course.courseName];
    
    _courseID.text = [NSString stringWithFormat: @"%@ PRE-TEST", thisTest.courseID];
    _courseID.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    _courseID.numberOfLines = 0;
    [_courseID sizeToFit];
    
    questions = thisTest.questions;
    count = 0;
    grade = 0;
    length = [questions count];
    
    if(questions.count == 0){
        return;
    }
    
    Question * q = [questions objectAtIndex: 0];
    answers = [@[q.key] mutableCopy];
    
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent= 30;
    _question.text = q.questionText;
    _question.font = [UIFont fontWithName: @"Thonburi" size:18];
    
    _question.numberOfLines = 0;
    [_question sizeToFit];
    
    //Set button texts
    [_exitButton setTitle: @"Give up" forState:UIControlStateNormal];
    
    _restart.hidden = YES;
    [_restart setTitle: @"Try Again" forState: UIControlStateNormal];
    [_option1 setTitle: @"A" forState: UIControlStateNormal];
    [_option2 setTitle: @"B" forState: UIControlStateNormal];
    [_option3 setTitle: @"C" forState: UIControlStateNormal];
    [_option4 setTitle: @"D" forState: UIControlStateNormal];
    
    if(q.options.intValue <= 0)
        _option1.hidden = YES;
    else
        _option1.hidden = NO;
    if(q.options.intValue <= 1)
        _option2.hidden = YES;
    else
        _option2.hidden = NO;
    if(q.options.intValue <= 2)
        _option3.hidden = YES;
    else
        _option3.hidden = NO;
    if(q.options.intValue <= 3)
        _option4.hidden = YES;
    else
        _option4.hidden = NO;
    
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
-(void) changeQuestion{
    if(count < length - 1){
        count ++;
        Question * q = questions[count];
        [answers addObject: q.key];
        _question.text = q.questionText;
        _question.numberOfLines = 0;
        [_question sizeToFit];
        
        if(q.options.intValue <= 0)
            _option1.hidden = YES;
        else
            _option1.hidden = NO;
        if(q.options.intValue <= 1)
            _option2.hidden = YES;
        else
            _option2.hidden = NO;
        if(q.options.intValue <= 2)
            _option3.hidden = YES;
        else
            _option3.hidden = NO;
        if(q.options.intValue <= 3)
            _option4.hidden = YES;
        else
            _option4.hidden = NO;
    }
    
    else{
        float fGrade = (float)grade/(float)[questions count] * 100;
        
        if(grade >= 0.8*(float)[questions count]){
            _question.text = [NSString stringWithFormat: @"\n\nCongratulations!\nYour Grade is %.0f\n\nYou are ready to take this course!", fGrade];
        }
        else {
            _question.text = [NSString stringWithFormat: @"\n\nUnfortunately,\nYour Grade is %.0f\n\nWe strongly recommand you to prepare better before taking this course.", fGrade];
        }
        
        [_exitButton setTitle: @"Back" forState:UIControlStateNormal];
        _question.font = [UIFont fontWithName: @"AmericanTypewriter" size:20];
        
        _option1.hidden = YES;
        _option2.hidden = YES;
        _option3.hidden = YES;
        _option4.hidden = YES;
        _restart.hidden = NO;
    }
    
}

- (IBAction)select1:(id)sender {
    if(count < length )
        if([answers[count]  isEqual: @1])
            grade++;
    [self changeQuestion];
}

- (IBAction)select2:(id)sender {
    if(count < length )
        if([answers[count]  isEqual: @2])
            grade++;
    [self changeQuestion];
}

- (IBAction)select3:(id)sender {
    if(count < length )
        if([answers[count]  isEqual: @3])
            grade++;
    [self changeQuestion];
}

- (IBAction)select4:(id)sender {
    if(count < length )
        if([answers[count]  isEqual: @4])
            grade++;
    [self changeQuestion];
}

- (IBAction)selectRestart:(id)sender {
    [self viewDidLoad];
}

@end
