//
//  ShengHuoChuXingVC.h
//  BinZang
//
//  Created by KimOkChol on 4/18/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShengHuoChuXingVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UIWebView *webContent1;
@property (weak, nonatomic) IBOutlet UIWebView *webContent2;
@property (weak, nonatomic) IBOutlet UIButton *btnPlane;
@property (weak, nonatomic) IBOutlet UIButton *btnTrain;

- (IBAction)onTapPlane:(id)sender;
- (IBAction)onTapTrain:(id)sender;



@end
