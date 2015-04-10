//
//  SignInViewController.h
//  pudu
//
//  Created by Danny on 3/4/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
-(void)initNetworkCommunication;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
-(void)sendRequest: (NSString *) request;

@end
