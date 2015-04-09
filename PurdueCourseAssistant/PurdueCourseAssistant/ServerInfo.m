//
//  ServerInfo.m
//  PurdueCourseAssistant
//
//  Created by SQuare on 4/5/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "ServerInfo.h"

@implementation ServerInfo

-(id)init{
    self = [super init];
    if(self){
        _hostAddress = @"128.10.25.217";
        _port = @6666;
    }
    return self;
}

@end
