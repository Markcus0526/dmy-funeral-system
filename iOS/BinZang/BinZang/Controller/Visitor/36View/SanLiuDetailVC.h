//
//  SanLiuDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SanLiuDetailVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webContents;

@property (nonatomic, retain) ST36View *		mViewInfo;

@end
