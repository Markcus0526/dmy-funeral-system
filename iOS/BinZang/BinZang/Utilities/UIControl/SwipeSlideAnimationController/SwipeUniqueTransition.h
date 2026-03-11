//
//  SwipeUniqueTransition.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeUniqueTransition : NSObject <NSCopying>


/**
 *  The class of the @c UIViewController being transitioned from.
 */
@property (assign, nonatomic) Class fromViewControllerClass;

/**
 *  The class of the @c UIViewController being transitioned to.
 */
@property (assign, nonatomic) Class toViewControllerClass;

- (instancetype)initWithAction:(Class)fromViewController
	 withToViewControllerClass:(Class)toViewController;


@end
