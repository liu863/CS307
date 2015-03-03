//
//  User.m
//  PurdueCourseAssistant
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "User.h"

@implementation User
-(id)init{
    self = [super init];
    if(self){
        _user_id = @"Jiaping Qi";
        _pwd = @"123456";
        _email = @"qi33@purdue.edu";
        Course * course = [[Course alloc] init];
        _courses = [[NSMutableArray alloc] initWithObjects: course,
                    nil];
    }
    return self;
}

@end
