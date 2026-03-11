//
//  LoginViewController.h
//  FSSystem
//
//  Created by Kim Ok Chol on 1/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *vwUsername;
@property (weak, nonatomic) IBOutlet UIView *vwPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckBox;


- (IBAction)onTapLogin:(id)sender;
- (IBAction)onTapCheckBox:(id)sender;


@end
