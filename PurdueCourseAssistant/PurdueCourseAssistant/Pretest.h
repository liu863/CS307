//
//  Pretest.h
//  myviews
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Pretest : NSObject

-(NSMutableArray *) getQuestions;
@property (strong, nonatomic) NSString * courseID;
@property (strong, nonatomic) NSMutableArray * questions;
@property (strong, nonatomic) NSMutableArray * answers;
-(id) initWithCourseTitle: (NSString *) courseTitle;

@end
