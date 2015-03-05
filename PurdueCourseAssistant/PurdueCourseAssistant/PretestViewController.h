//
//  PretestViewController.h
//  PreTest
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PretestViewController : UIViewController

- (IBAction)select1:(id)sender;
- (IBAction)select2:(id)sender;
- (IBAction)select3:(id)sender;
- (IBAction)select4:(id)sender;
- (IBAction)selectRestart:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *courseID;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *option1;
@property (weak, nonatomic) IBOutlet UIButton *option2;
@property (weak, nonatomic) IBOutlet UIButton *option3;
@property (weak, nonatomic) IBOutlet UIButton *option4;
@property (weak, nonatomic) IBOutlet UIButton *restart;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

-(void) changeQuestion;

@end
