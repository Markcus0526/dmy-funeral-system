//
//  ShengHuoJingDianDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 4/20/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShengHuoJingDianDetailVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UIWebView *webContent;


@property (nonatomic, retain) STMtQiPan *			mDetailInfo;

@end
