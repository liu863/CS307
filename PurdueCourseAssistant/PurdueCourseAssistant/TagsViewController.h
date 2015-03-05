//
//  TagsViewController.h
//  PurdueCourseAssistant
//
//  Created by w23html on 3/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsViewController : UIViewController
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
@property (weak, nonatomic) IBOutlet UIButton *tag8;
@property (weak, nonatomic) IBOutlet UIButton *tag9;
@property (weak, nonatomic) IBOutlet UIButton *tag10;
@property (weak, nonatomic) IBOutlet UIButton *tag11;
@property (weak, nonatomic) IBOutlet UIButton *tag12;
@property (weak, nonatomic) IBOutlet UIButton *go;
- (IBAction)goPressed:(id)sender;

@end
