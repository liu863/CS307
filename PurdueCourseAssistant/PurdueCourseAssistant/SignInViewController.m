///
//  SignInViewController.m
//  pudu
//
//  Created by Danny on 3/4/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()


@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _password.secureTextEntry = true;    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    NSString *Username = [_username text];
    NSString *Password = [_password text];
    if ([_username.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in username" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
        
    }else if([_password.text length] == 0){
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        NSLog(@"%@", Username);
        NSLog(@"%@", Password);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
