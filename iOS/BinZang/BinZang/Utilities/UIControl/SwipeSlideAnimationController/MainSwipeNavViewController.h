//
//  MainSwipeNavViewController.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeSlideAnimationController.h"
#import "BaseSwipeInteractionController.h"

@interface MainSwipeNavViewController : UINavigationController <UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *interactionControllers;

- (void)setInteractionController:(id<SwipeTransitionInteractionController>)interactionController
			  fromViewController:(Class)fromViewController
				toViewController:(Class)toViewController;
@end
