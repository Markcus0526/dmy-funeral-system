//
//  ZhengQuQuanJingVC.h
//  BinZang
//
//  Created by RyuCholJin on 4/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"

@interface ZhengQuQuanJingVC : VisitorSuperViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;

@property (nonatomic) long nUidOfQuanJing;

@property (nonatomic) int nViewDidAppear;
- (IBAction)OnClickChangeScene:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeBackground;

@end
