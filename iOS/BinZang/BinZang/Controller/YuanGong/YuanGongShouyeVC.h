//
//  YuanGongShouyeVC.h
//  BinZang
//
//  Created by Beids on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "MainSwipeViewController.h"

@interface YuanGongShouyeVC : MainSwipeViewController<ComSvcDelegate, SGFocusImageFrameDelegate>

-(void) setPartnerViewController:(UIViewController*)viewController;


- (IBAction)OnLingYuanYuLiu:(id)sender;
- (IBAction)OnJiangJinJiSuan:(id)sender;
- (IBAction)OnZhangDanChaXun:(id)sender;
- (IBAction)OnLuoZangYiShiYuYue:(id)sender;
- (IBAction)OnDaiDingJiPinGouMai:(id)sender;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *_buttons;
@property (weak, nonatomic) IBOutlet UIView *vwSliderContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblHuoDongNotifier;
@property (weak, nonatomic) IBOutlet UILabel *lblZiYouNotifier;

@end
