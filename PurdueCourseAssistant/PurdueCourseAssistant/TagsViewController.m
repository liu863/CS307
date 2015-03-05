//
//  TagsViewController.m
//  PurdueCourseAssistant
//
//  Created by w23html on 3/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "TagsViewController.h"

@interface TagsViewController ()

@end

@implementation TagsViewController

int tags[12] = {0,0,0,0,0,0,0,0,0,0,0,0};
int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)goPressed:(id)sender {
    if (count > 3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You can not choose more than 3 tags!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        for (int i = 0; i < 12; i++) {
            if (tags[i] == 1) {
                NSLog(@"Tag: %d (index) is choose!\n", i);
            }
        }
    }
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
}
@end
