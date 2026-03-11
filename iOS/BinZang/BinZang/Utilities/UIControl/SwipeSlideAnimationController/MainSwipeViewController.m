//
//  MainSwipeViewController.m
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MainSwipeViewController.h"
#import "MainSwipeNavViewController.h"

@interface MainSwipeViewController () <SwipeTransitionInteractionControllerDelegate>
{
	UIViewController *			nextViewController;
}

@property (nonatomic, strong) id<SwipeTransitionInteractionController> pushPopInteractionController;
//@property (weak, nonatomic) id<SwipeTransitionInteractionController> pushPopInteractionController;


@end

@implementation MainSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	if ([self.navigationController isKindOfClass:[MainSwipeNavViewController class]])
	{
		self.pushPopInteractionController = [[BaseSwipeInteractionController alloc] init];
		[self.pushPopInteractionController setNextViewControllerDelegate:self];
		[self.pushPopInteractionController attachViewController:self];
		[(MainSwipeNavViewController *)self.navigationController setInteractionController:self.pushPopInteractionController
																	   fromViewController:[self class]
																		 toViewController:nil];
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

- (void) initSwipe
{
	
}

- (void) setNextViewController : (UIViewController *)nextVC
{
	nextViewController = nextVC;
}

- (IBAction)pushNextViewController:(id)sender
{
	// check child vc & remove old one
	if ([self.navigationController.childViewControllers count] > 1)
	{
		NSMutableArray * newChilds = [[NSMutableArray alloc] init];
		NSInteger lastVCPos = [self.navigationController.childViewControllers count] - 1;
		[newChilds addObject:[self.navigationController.childViewControllers objectAtIndex:lastVCPos]];
		
		[self.navigationController setViewControllers:newChilds];
	}
	
	// push next view controller
	[[self navigationController] pushViewController:[self nextSimpleViewController] animated:YES];
}

#pragma mark - Next View Controller Logic

- (UIViewController *)nextSimpleViewController
{
	return nextViewController;
}


#pragma mark - RZTransitionInteractorDelegate

- (UIViewController *)nextViewControllerForInteractor:(id<SwipeTransitionInteractionController>)interactor
{
	return [self nextSimpleViewController];
}


@end
