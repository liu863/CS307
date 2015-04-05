//
//  MyInfoViewController.h
//  Start
//
//  Created by ZhengshangLiu on 15/3/4.
//  Copyright (c) 2015年 ZhengshangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Emailaddr;
@property (weak, nonatomic) IBOutlet UITextView *Courses;

-(void)initNetworkCommunication;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
-(void)sendRequest: (NSString *) request;
@end
