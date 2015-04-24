//
//  CourseListTableViewController.m
//  PurdueCourseAssistant
//
//  Created by Ransen on 3/2/15.
//  Copyright (c) 2015 team_9. All rights reserved.
//

#import "CourseListTableViewController.h"
#import "Course.h"
@interface CourseListTableViewController ()


@end

NSArray * list;
NSUInteger count;
NSString * courses;
int i;

@implementation CourseListTableViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    /*
     Course * course1 = [[Course alloc] init];
     course1.courseName = @"CS381";
     course1.courseDescription = @"asd";
     course1.courseTag = @"123";
     course1.courseRating = [NSNumber numberWithDouble:1.6];
     course1.courseComment = @[@"good", @"bad"];
     [self.courseList addObject: course1];
     //[self.courseList addObject:course1];
     self.courseList = [[NSMutableArray alloc] initWithObjects: course1, nil];
     Course * course2 = [[Course alloc] init];
     course2.courseName = @"CS307";
     course2.courseDescription = @"a123d";
     course2.courseTag = @"234";
     course2.courseRating = [NSNumber numberWithDouble:2];
     course2.courseComment = @[@"go!o!d", @"bad!"];
     [self.courseList addObject: course2];*/
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    courses = course.courseList;
    NSLog(@"courseList in ListVC = %@", courses);
    list = [courses componentsSeparatedByString:@"|"];
    count = [list count];
    i = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //NSLog(@"flag 1= %u", [self.courseList count]);
    //return [self.courseList count];
    return count-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    printf("~~~~~~~~\n");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    //cell.textLabel.text = [tabledata objectAtIndex:indexPath.row];
    if(cell == nil)
    {
        NSLog(@"~~~~~~~~\n");
    }
    //Course *current = [self.courseList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = list[i++];//@"asa";//current.courseName;
    // Configure the cell...
    
    return cell;
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //Course *currentCourse = [self.courseList objectAtIndex:indexPath.row];
    
    NSInteger j = indexPath.row;
    //NSLog(@"flag count = %lu, j = %lu, courseName = %@\n",[list count], j, list[j]);
    course.courseName = list[j+1];
    //NSLog(@"courseName ===== %@\n", course.courseName);
}

@end
