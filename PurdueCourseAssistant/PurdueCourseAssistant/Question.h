//
//  Question.h
//  myviews
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString * questionText;
@property (strong, nonatomic) NSNumber * options;
@property (strong, nonatomic) NSNumber * key;

@end
