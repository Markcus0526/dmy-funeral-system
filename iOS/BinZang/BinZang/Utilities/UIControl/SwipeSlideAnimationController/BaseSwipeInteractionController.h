//
//  BaseSwipeInteractionController.h
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SwipeTransitionInteractionController;
@protocol SwipeTransitionInteractionControllerDelegate;

@protocol SwipeTransitionInteractionControllerDelegate <NSObject>

@optional

/**
 *  Used to specify the next @c UIViewController that is shown when an interactor is ready to present, push, or move to a new tab.
 *
 *  @param interactor The interactor that is requesting a new @c UIViewController.
 *
 *  @return the @c UIViewController to be shown.
 */
- (UIViewController *)nextViewControllerForInteractor:(id<SwipeTransitionInteractionController>)interactor;

@end





@protocol SwipeTransitionInteractionController <UIViewControllerInteractiveTransitioning>

@required

/**
 *  Is the transition interaction controller currently in a user interaction state.
 */
@property (nonatomic, assign, readwrite) BOOL isInteractive;

/**
 *  Should the transition interaction controller complete the transaction if it is released in its current state.  Ex: a swipe interactor should not complete until it has passed a threshold percentage.
 */
@property (nonatomic, assign, readwrite) BOOL shouldCompleteTransition;

/**
 *  The delegate that allows the interaction controller to receive a @UIViewController to display for positive actions such as push and present.
 */
@property (nonatomic, weak) id<SwipeTransitionInteractionControllerDelegate> nextViewControllerDelegate;

/**
 *  Initialize the Interaction Controller in the supplied @c UIViewController.  Typically adds a gesture recognizer to the @c UIViewController's view.
 *
 *  @param viewController the @c UIViewController that has interactions to transition with.
 *  @param action         the bitmap of action the interaction controller should respond to.
 */
- (void)attachViewController:(UIViewController *)viewController;

@end







@interface BaseSwipeInteractionController : UIPercentDrivenInteractiveTransition <UIGestureRecognizerDelegate, SwipeTransitionInteractionController>

@property (nonatomic, strong) UIViewController *fromViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, assign) BOOL reverseGestureDirection;

- (BOOL)isGesturePositive:(UIPanGestureRecognizer *)panGestureRecognizer;
- (CGFloat)swipeCompletionPercent;
- (CGFloat)translationPercentageWithPanGestureRecongizer:(UIPanGestureRecognizer *)panGestureRecognizer;
- (CGFloat)translationWithPanGestureRecongizer:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
