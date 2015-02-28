//
//  Course.h
//  PurdueCourseAssistant
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (weak, nonatomic) NSString * courseName;
@property (weak, nonatomic) NSString * courseDescription;
@property (weak, nonatomic) NSString * courseTag;
@property (weak, nonatomic) NSNumber * courseRating;
@property (weak, nonatomic) NSArray * courseComment;

@end
