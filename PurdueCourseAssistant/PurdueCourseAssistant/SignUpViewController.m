//
//  SignUpViewController.m
//  pudu
//
//  Created by Danny on 3/3/15.
//  Copyright (c) 2015 Danny. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()





@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Password.secureTextEntry = true;
    _rePassword.secureTextEntry = true;     // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Signup:(id)sender {
    NSString *Username = [_Username text];
    NSString *Password = [_Password text];
    NSString *Repswd = [_rePassword text];
    NSString *Email = [_Email text];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([_Username.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in username" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_Password.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_rePassword.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please retype password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }else if ([_Email.text length] == 0) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please fill in E-MAIL" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    } else if ([emailTest evaluateWithObject:_Email.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }else if ([_Password.text isEqualToString:_rePassword.text]) {
        NSLog(@"%@", Username);
        NSLog(@"%@", Password);
        
        NSLog(@"%@", Repswd);
        NSLog(@"%@", Email);
        
    }else {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Wrong Message" message:@"Please type same password" delegate:self cancelButtonTitle:@"CANCE" otherButtonTitles:@"OK", nil];
        [alert show];
    }
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
