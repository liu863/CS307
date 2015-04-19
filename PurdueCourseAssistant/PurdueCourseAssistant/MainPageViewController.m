//
//  MainPageViewController.m
//  PurdueCourseAssistant
//
//  Created by SQuare on 4/10/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "MainPageViewController.h"
#import "Course.h"
#import "User.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)viewallCourse:(id)sender {
    course.tags = @"000";
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
