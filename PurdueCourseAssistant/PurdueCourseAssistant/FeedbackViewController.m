//
//  FeedbackViewController.m
//  Sec
//
//  Created by w23html on 2/28/15.
//  Copyright (c) 2015 w23html. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

int tag[10] = {0,0,0,0,0,0,0,0,0,0};

- (void)viewDidLoad {
    [super viewDidLoad];
    [_score setText:@"4.0/5.0"];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Thanks for your feedback!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    NSLog(@"Received Rating: %1.1f\n", [_slider value]);
    int i = 0;
    while (i < 10) {
        if (tag[i] == 1)
            NSLog(@"Received Tag: %d (index)\n", i);
        i++;
    }
    NSLog(@"Received Comment: %@\n", [_comment text]);
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
@end
