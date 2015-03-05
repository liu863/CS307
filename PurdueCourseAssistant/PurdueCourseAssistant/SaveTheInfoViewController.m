//
//  SaveTheInfoViewController.m
//  PurdueCourseAssistant
//
//  Created by Hao Xu on 3/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "SaveTheInfoViewController.h"

@interface SaveTheInfoViewController ()

@end

@implementation SaveTheInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSString *nickname = [_nickname text];
    NSString *email = [_email text];
    NSString *courselist = [_courselist text];
    if([_nickname.text length] != 0)
        NSLog(@"%@", nickname);
    if([_email.text length] != 0)
        NSLog(@"%@", email);
    if([_courselist.text length] != 0)
        NSLog(@"%@", courselist);
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
