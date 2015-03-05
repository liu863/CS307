//
//  DismissPretestSegue.m
//  PreTest
//
//  Created by SQuare on 3/4/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "DismissPretestSegue.h"

@implementation DismissPretestSegue
-(void)perform {
    UIViewController * source = (UIViewController *) self.sourceViewController;
    [source.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
