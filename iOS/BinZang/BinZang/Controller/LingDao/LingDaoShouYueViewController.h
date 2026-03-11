//
//  LingDaoShouYueViewController.h
//  BinZang
//
//  Created by KimOkChol on 5/4/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "MainSwipeViewController.h"

@interface LingDaoShouYueViewController : MainSwipeViewController <ComSvcDelegate, SGFocusImageFrameDelegate>
@property (weak, nonatomic) IBOutlet UIView * vwSliderContainer;
@end
