//
//  FuWuRenYuanVC.h
//  BinZang
//
//  Created by Admin on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuWuRenYuanVC : CustomerSuperViewController

@property (nonatomic, retain) STOfficeEmp *	mManInfo;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *mJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *mOfficeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mAddressLabel;


- (IBAction)ClickPhoneNumber:(id)sender;
@end
