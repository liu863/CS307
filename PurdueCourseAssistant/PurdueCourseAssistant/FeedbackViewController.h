//
//  FeedbackViewController.h
//  Sec
//
//  Created by w23html on 2/28/15.
//  Copyright (c) 2015 w23html. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag1;
- (IBAction)tag1Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag2;
- (IBAction)tag2Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag3;
- (IBAction)tag3Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag4;
- (IBAction)tag4Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag5;
- (IBAction)tag5Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag6;
- (IBAction)tag6Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag7;
- (IBAction)tag7Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag8;
- (IBAction)tag8Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag9;
- (IBAction)tag9Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tag10;
- (IBAction)tag10Pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *comment;

- (IBAction)buttonPressed:(id)sender;
@end
