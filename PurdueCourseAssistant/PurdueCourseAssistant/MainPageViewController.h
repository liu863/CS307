//
//  MainPageViewController.h
//  PurdueCourseAssistant
//
//  Created by SQuare on 4/10/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageViewController : UIViewController

-(void)initNetworkCommunication;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;
-(void)sendRequest: (NSString *) request;
@property (strong, nonatomic) IBOutlet UIButton *viewcourse;

@end
