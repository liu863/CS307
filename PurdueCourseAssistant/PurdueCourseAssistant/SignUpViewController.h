//
//  SignUpViewController.h
//  pudu
//
//  Created by Danny on 3/3/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *PassWord;
@property (weak, nonatomic) IBOutlet UILabel *RePassWord;
@property (weak, nonatomic) IBOutlet UILabel *EMail;

@property (weak, nonatomic) IBOutlet UITextField *Username;

@property (weak, nonatomic) IBOutlet UITextField *Password;

@property (weak, nonatomic) IBOutlet UITextField *rePassword;

@property (weak, nonatomic) IBOutlet UITextField *Email;

-(void)initNetworkCommunication;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
-(void)sendRequest: (NSString *) request;

@end
