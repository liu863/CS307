//
//  SignUpViewController.h
//  pudu
//
//  Created by Danny on 3/3/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *Username;

@property (weak, nonatomic) IBOutlet UITextField *Password;

@property (weak, nonatomic) IBOutlet UITextField *rePassword;

@property (weak, nonatomic) IBOutlet UITextField *Email;
@end
