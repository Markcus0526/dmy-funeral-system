//
//  ShouHouMainVC.h
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouHouMainVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UIView *vwFst;
@property (weak, nonatomic) IBOutlet UIView *vwSec;

@property (weak, nonatomic) IBOutlet UIButton *btnTabFst;
@property (weak, nonatomic) IBOutlet UIButton *btnTabSec;

- (IBAction)onTapFst:(id)sender;
- (IBAction)onTapSec:(id)sender;


@end
