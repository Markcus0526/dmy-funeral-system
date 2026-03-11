//
//  MainSwipeNavViewController.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MainSwipeNavViewController.h"
#import "SwipeUniqueTransition.h"
#import "MainSwipeViewController.h"


@interface MainSwipeNavViewController () <UIGestureRecognizerDelegate>

@end

@implementation MainSwipeNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.interactionControllers = [[NSMutableDictionary alloc] init];
	
	__weak MainSwipeNavViewController *weakSelf = self;
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		[self.interactivePopGestureRecognizer setEnabled:YES];
		self.interactivePopGestureRecognizer.delegate = weakSelf;
		self.delegate = self;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setInteractionController:(id<SwipeTransitionInteractionController>)interactionController
							  fromViewController:(Class)fromViewController
								toViewController:(Class)toViewController
{
	
	SwipeUniqueTransition *keyValue = nil;

		keyValue = [[SwipeUniqueTransition alloc] initWithAction:fromViewController withToViewControllerClass:toViewController];
	
	[self.interactionControllers setObject:interactionController forKey:keyValue];
	
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
						  interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
	return [self interactionControllerForAction:animationController];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								   animationControllerForOperation:(UINavigationControllerOperation)operation
												fromViewController:(UIViewController *)fromVC
												  toViewController:(UIViewController *)toVC
{
	// check main view allow swipe animation
	if ([fromVC isKindOfClass:[MainSwipeViewController class]]
		&& ([toVC isKindOfClass:[MainSwipeViewController class]]))
	{
		switch (operation) {
			case UINavigationControllerOperationPush:
			{
				SwipeSlideAnimationController * animCtrl = [[SwipeSlideAnimationController alloc] init];
				return animCtrl;
			}
			case UINavigationControllerOperationPop:
			default:
				return nil;
		}
	}
	return nil;
}

#pragma mark - UIInteractionController Caching

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForAction:(id <UIViewControllerAnimatedTransitioning>)animationController
{
	for (SwipeUniqueTransition *key in self.interactionControllers) {
		id<SwipeTransitionInteractionController> interactionController = [self.interactionControllers objectForKey:key];
		if ([interactionController isInteractive]) {
			return interactionController;
		}
	}
	
	return nil;
}

@end
