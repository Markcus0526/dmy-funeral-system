//
//  BaseSwipeInteractionController.m
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BaseSwipeInteractionController.h"

#define kBaseSwipeInteractionDefaultCompletionPercentage  0.3f


@implementation BaseSwipeInteractionController

@synthesize isInteractive = _isInteractive;
@synthesize nextViewControllerDelegate = _delegate;
@synthesize shouldCompleteTransition = _shouldCompleteTransition;

- (id)init
{
	self = [super init];
	if (self) {
		_reverseGestureDirection = YES;
	}
	return self;
}

- (void)attachViewController:(UIViewController *)viewController
{
	self.fromViewController = viewController;
	[self attachGestureRecognizerToView:self.fromViewController.view];
}

- (void)attachGestureRecognizerToView:(UIView*)view {
	[view addGestureRecognizer:self.gestureRecognizer];
}

-(void)dealloc
{
	[self.gestureRecognizer.view removeGestureRecognizer:self.gestureRecognizer];
}

- (CGFloat)completionSpeed
{
	return 1 - self.percentComplete;
}




#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
		UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer*)gestureRecognizer;
		CGFloat yTranslation = [panGestureRecognizer translationInView:panGestureRecognizer.view].y;
		return yTranslation == 0;
	}
	
	return YES;
}


#pragma mark - UIPanGestureRecognizer Delegate

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
	CGFloat percentage = [self translationPercentageWithPanGestureRecongizer:panGestureRecognizer];
	BOOL positiveDirection = self.reverseGestureDirection ? ![self isGesturePositive:panGestureRecognizer] : [self isGesturePositive:panGestureRecognizer];
	
	switch (panGestureRecognizer.state) {
		case UIGestureRecognizerStateBegan:
			self.isInteractive = YES;
			
			// check positive swipe gesture
			if (positiveDirection && self.nextViewControllerDelegate)
			{
				UINavigationController *navigation = self.fromViewController.navigationController;
				UIViewController * pushVC = [self.nextViewControllerDelegate nextViewControllerForInteractor:self];
				
				// check child vc & remove old one
				if ([navigation.childViewControllers count] > 1)
				{
					NSMutableArray * newChilds = [[NSMutableArray alloc] init];
					NSInteger lastVCPos = [navigation.childViewControllers count] - 1;
					[newChilds addObject:[navigation.childViewControllers objectAtIndex:lastVCPos]];
					
					[navigation setViewControllers:newChilds];
				}
				[navigation pushViewController:pushVC animated:YES];
				
			}
			break;
			
		case UIGestureRecognizerStateChanged:
			if (self.isInteractive)
			{
				self.shouldCompleteTransition = (percentage > [self swipeCompletionPercent]);
				[self updateInteractiveTransition:percentage];
			}
			break;
			
		case UIGestureRecognizerStateCancelled:
			self.isInteractive = NO;
			[self cancelInteractiveTransition];
			break;
			
		case UIGestureRecognizerStateEnded:
			if (self.isInteractive)
			{
				self.isInteractive = NO;
				if (!self.shouldCompleteTransition || panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
					[self cancelInteractiveTransition];
				}
				else {
					[self finishInteractiveTransition];
				}
			}
			
		default:
			break;
	}
}

- (BOOL)isGesturePositive:(UIPanGestureRecognizer *)panGestureRecognizer
{
	return [self translationWithPanGestureRecongizer:panGestureRecognizer] < 0;
}

- (CGFloat)swipeCompletionPercent
{
	return kBaseSwipeInteractionDefaultCompletionPercentage;
}

- (CGFloat)translationPercentageWithPanGestureRecongizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
	return fabsf([self translationWithPanGestureRecongizer:panGestureRecognizer] / panGestureRecognizer.view.bounds.size.width);
}

- (CGFloat)translationWithPanGestureRecongizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
	return [panGestureRecognizer translationInView:panGestureRecognizer.view].x;
}

#pragma mark - Overridden Properties

- (UIGestureRecognizer*)gestureRecognizer
{
	if (!_gestureRecognizer)
	{
		_gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
		[_gestureRecognizer setDelegate:self];
	}
	return _gestureRecognizer;
}

@end
