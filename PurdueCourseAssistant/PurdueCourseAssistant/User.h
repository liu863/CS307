//
//  User.h
//  PurdueCourseAssistant
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface User : NSObject

extern User *user;

@property (strong, nonatomic) NSString * user_id;
@property (strong, nonatomic) NSString * nickname;
@property (strong, nonatomic) NSString * pwd;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * courses;
@property (strong, nonatomic) NSString * userInfo;

@end
