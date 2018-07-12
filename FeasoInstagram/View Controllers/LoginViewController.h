//
//  LoginViewController.h
//  FeasoInstagram
//
//  Created by Jonathan Cabrera on 7/9/18.
//  Copyright © 2018 Jonathan Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end
