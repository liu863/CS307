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

-(id)init {
    return [self initWithCourseTitle:@"CS30700"];
}

-(id) initWithCourseTitle: (NSString *) courseTitle {
    self = [super init];
    NSLog(@"courseTitle = %@", courseTitle);
    if(self){
        NSLog(@"courseTitle = %@", courseTitle);
        if( [courseTitle isEqual:@"CS381"] ){
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
            q.questionText = @"4. A dynamic programming algorithm cannot have exponential running time when solutions to subproblems are not recomputed.\n\nA. True\nB. False ";
            q.options = @2;
            q.key = @2;
            [_questions addObject:q];
            
            q = [[Question alloc] init];
            q.questionText = @"5. In a min-heap the maximum element will always be at a leaf.\n\nA. True\nB. False";
            q.options = @2;
            q.key = @1;
            [_questions addObject:q];
            
            q = [[Question alloc] init];
            q.questionText = @"6. Given is an array of size n containing numbers in arbitrary order and an integer k. The k smallest elements (in arbitrary order) can be found in what time? Indicate smallest worst-case time that holds.\n\nA. O(n log n)\nB. O(n)\nC. O(n + k log n)";
            q.options = @3;
            q.key = @2;
            [_questions addObject:q];
        }
        else if ([courseTitle isEqual:@"CS307"]){
            _courseID = @"CS30700";
            Question * q = [[Question alloc] init];
            q.questionText = @"1. What is the Software Quality attribute concerned with whether or not the software can handle large volumes of data?\n\nA. Usability\nB. Scalability\nC. Performance\nD. Efficiency";
            q.options =  @4;
            q.key = @2;
            
            _questions = [@[q] mutableCopy];
            
            q = [[Question alloc] init];
            q.questionText = @"2. What Software Quality attribute most often conflicts with Security?\n\nA. Usability\nB. Scalability\nC. Performance\nD. Availability";
            q.options = @4;
            q.key = @3;
            [_questions addObject: q];
            
            q = [[Question alloc] init];
            q.questionText = @"3. You can introduce a completely new feature or concept and not mess up the working code by ...?\n\nA. Change/Bug Tracking\nB. Committing\nC. Branching\nD. Reverting";
            q.options = @4;
            q.key = @3;
            [_questions addObject: q];
            
            q = [[Question alloc] init];
            q.questionText = @"4. Which of the following is a demo of the product being produced?\n\nA. Sprint Review Meeting\nB. Sprint Retrospective Meeting\nC. Daily Scrum\nD. Stand-up Meeting";
            q.options = @4;
            q.key = @1;
            [_questions addObject:q];
            
            q = [[Question alloc] init];
            q.questionText = @"5. A client that is as small as possible so that most of the work is done on the server is called a (an)...\n\nA. abstract client\nB. virtual client\nC. fat client\nD. thin client";
            q.options = @4;
            q.key = @4;
            [_questions addObject:q];
            
            q = [[Question alloc] init];
            q.questionText = @"6. To model the dynamic aspects of a software system and to show the sequence of messages exchanged by the set of objects performing a certain task, we use....\n\nA. Transition Diagrams\nB. State Diagrams\nC. Communication Diagrams\nD. Sequence Diagrams";
            q.options = @4;
            q.key = @4;
            [_questions addObject:q];
        }
        
        
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
