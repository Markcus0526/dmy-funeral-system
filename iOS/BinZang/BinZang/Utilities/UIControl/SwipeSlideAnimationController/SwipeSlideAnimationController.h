//
//  SwipeSlideAnimationController.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeSlideAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat transitionTime;
@property (nonatomic, assign) BOOL horizontalOrientation;
@property (nonatomic, strong) UIColor *containerBackgroundColor;


@end
