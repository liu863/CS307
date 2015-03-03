//
//  Course.m
//  PurdueCourseAssistant
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "Course.h"

@implementation Course
-(id)init{
    self = [super init];
    if(self){
        _courseName = @"CS30700";
        _courseRating = @5;
        _courseTag = @"Ez";
        _courseComment = [[NSMutableArray alloc] initWithObjects: @"Nice professor, ez grading.",
                         nil];
        _courseDescription = @"(a) Introduce fundamental principles, techniques, and tools used in the design of modern industrial-strength software systems, (b) provide an opportunity to work in small teams, and (c) assist in sharpening of documentation and presentation skills.";
    }
    return self;
}


@end
