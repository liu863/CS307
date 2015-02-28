//
//  User.h
//  PurdueCourseAssistant
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (weak, nonatomic) NSString * user_id;
@property (weak, nonatomic) NSString * pwd;
@property (weak, nonatomic) NSString * email;
@property (weak, nonatomic) NSArray * courses;

@end
