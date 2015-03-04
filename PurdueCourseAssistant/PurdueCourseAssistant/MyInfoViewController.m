//
//  MyInfoViewController.m
//  Start
//
//  Created by ZhengshangLiu on 15/3/4.
//  Copyright (c) 2015年 ZhengshangLiu. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Name.text = @"Jiaping Qi";
    _Emailaddr.text = @"qi33@purdue.edu";
    _Courses.text = @"CS307\nCS180\nCS182\nCS240\nCS250\nCS251\nCS252\nCS381\nCS408\n";
    _Courses.editable = NO;
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
