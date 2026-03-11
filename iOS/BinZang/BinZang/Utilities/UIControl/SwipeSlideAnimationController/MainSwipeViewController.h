//
//  MainSwipeViewController.h
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSwipeInteractionController.h"

@interface MainSwipeViewController : UIViewController

- (void) setNextViewController : (UIViewController *)nextVC;

- (IBAction)pushNextViewController:(id)sender;

@end
