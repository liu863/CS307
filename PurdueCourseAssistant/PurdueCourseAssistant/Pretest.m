//
//  Pretest.m
//  myviews
//
//  Created by SQuare on 2/28/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "Pretest.h"
#import "Question.h"

@implementation Pretest

-(id) init {
    self = [super init];
    if(self){
        _courseID = @"CS38100";
        Question * q = [[Question alloc] init];
        q.questionText = @"1. Array A contains entries in increasing order.\nSuch an ordering corresponds to what type of heap?\n\nA.Max-heap\nB.Min-heap\nC.Ordering does not represent a heap";
        q.options =  @3;
        q.key = @2;
        
        _questions = [@[q] mutableCopy];
        
        q = [[Question alloc] init];
        q.questionText = @"2. You need to build a min-heap on n elements.\nIf the n elements are known, the min-heap can be\ncreated in what time?\nIndicate smallest time that applies.\n\nA. O(log n)\nB. O(n)\nC. O(n log n)\nD. O(n2)";
        q.options = @4;
        q.key = @2;
        [_questions addObject: q];
        
        q = [[Question alloc] init];
        q.questionText = @"3. Finding a longest increasing subsequence in a string of length n\nThe string\n5 8 7 3 1 2 9 3 4 10 6 11\nhas a longest increasing subsequence of length\n\nA. 4\nB. 5\nC. 6\nD. 7";
        q.options = @4;
        q.key = @3;
        [_questions addObject: q];
        
        q = [[Question alloc] init];
        q.questionText = @"A dynamic programming algorithm cannot have exponential running time when solutions to subproblems are not recomputed.\n\nA. True\nB. False ";
        q.options = @2;
        q.key = @2;
        [_questions addObject:q];
        
        q = [[Question alloc] init];
        q.questionText = @"In a min-heap the maximum element will always be at a leaf.\n\nA. True\nB. False";
        q.options = @2;
        q.key = @1;
        [_questions addObject:q];
        
        q = [[Question alloc] init];
        q.questionText = @"Given is an array of size n containing numbers in arbitrary order and an integer k. The k smallest elements (in arbitrary order) can be found in what time? Indicate smallest worst-case time that holds.\n\nA. O(n log n)\nB. O(n)\nC. O(n + k log n)";
        q.options = @3;
        q.key = @2;
        [_questions addObject:q];
        
        
    }
    return self;
}

-(id) initWithCourseID {
    self = [super init];
    if(self){
    }
    return self;
}

-(NSArray *) getQuestions{
    return _questions;
}

@end
