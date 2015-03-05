//
//  Question.m
//  myviews
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "Question.h"

@implementation Question

-(id)init {
    self = [super init];
    if(self){
        _questionText = @"empty";
        _options =  @0;
        _key = @0;
    }
    return self;
}


@end
