//
//  CusMainViewController.h
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "MainSwipeViewController.h"

@interface CusMainViewController : MainSwipeViewController <ComSvcDelegate, SGFocusImageFrameDelegate>

@property (weak, nonatomic) IBOutlet UIView * vwSliderContainer;

@property (weak, nonatomic) IBOutlet UIView *vwRelTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblTmpRelative;
@property (weak, nonatomic) IBOutlet UILabel *lblTmpArea;
@property (weak, nonatomic) IBOutlet UILabel *lblTmpBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblTmpDeathday;


@end
