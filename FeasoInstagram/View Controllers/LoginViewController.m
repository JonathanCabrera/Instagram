//
//  LoginViewController.m
//  FeasoInstagram
//
//  Created by Jonathan Cabrera on 7/9/18.
//  Copyright © 2018 Jonathan Cabrera. All rights reserved.
//

#import "LoginViewController.h"
//#import "Parse.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)registerUser {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            [self errorDuringSubmisson];
            NSLog(@"Error: %@", error.localizedDescription);

        } else {
            NSLog(@"User registered successfully");

            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            [self errorDuringSubmisson];
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");

            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)errorDuringSubmisson {
    NSString *SubmissonErrorMessage = @"There was an error during sign up.";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                   message:SubmissonErrorMessage
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (bool) emptyFieldAlertMessage:(NSString *) username alongWith:(NSString *) password {
    NSString *emptyFieldMessage = @"Username or password is empty.";
    
    bool hasEmptyField = [username isEqualToString:@""] || [password isEqualToString:@""];
    
    if (hasEmptyField) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                       message:emptyFieldMessage
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    return hasEmptyField;
}


- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
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
