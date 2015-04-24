///
//  ForgotPasswordViewController.h
//  pudu
//
//  Created by Danny on 3/4/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *findpwd;
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UITextField *Username;
-(void)initNetworkCommunication;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
-(void)sendRequest: (NSString *) request;
@end
