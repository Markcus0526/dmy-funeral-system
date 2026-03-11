//
//  SwipeSlideAnimationController.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "SwipeSlideAnimationController.h"

#define kRZSlideTransitionTime 0.35
#define kRZSlideScaleChangePct 0.33

@implementation SwipeSlideAnimationController

- (id)init
{
	self = [super init];
	if (self)
	{
		_transitionTime = kRZSlideTransitionTime;
		_horizontalOrientation = TRUE;
		_containerBackgroundColor = [UIColor blackColor];
	}
	return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *container = [transitionContext containerView];
	
	UIView *bgView = [[UIView alloc] initWithFrame:container.bounds];
	bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	bgView.backgroundColor = self.containerBackgroundColor;
	[container insertSubview:bgView atIndex:0];
	
	// start animation
	[container insertSubview:toViewController.view belowSubview:fromViewController.view];
	toViewController.view.transform = CGAffineTransformMakeScale(1.0 - kRZSlideScaleChangePct, 1.0 - kRZSlideScaleChangePct);
	toViewController.view.alpha = 0.1f;
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 toViewController.view.transform = CGAffineTransformIdentity;
						 toViewController.view.alpha = 1.0f;
						 if (self.horizontalOrientation)
						 {
							 fromViewController.view.transform = CGAffineTransformMakeTranslation(container.bounds.size.width, 0);
						 }
						 else
						 {
							 fromViewController.view.transform = CGAffineTransformMakeTranslation(0, container.bounds.size.height);
						 }
					 }
					 completion:^(BOOL finished) {
						 toViewController.view.transform = CGAffineTransformIdentity;
						 fromViewController.view.transform = CGAffineTransformIdentity;
						 [bgView removeFromSuperview];
						 [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
					 }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
	return self.transitionTime;
}

@end
