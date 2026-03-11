//
//  SwipeUniqueTransition.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "SwipeUniqueTransition.h"

@implementation SwipeUniqueTransition


- (instancetype)initWithAction:(Class)fromViewController
	 withToViewControllerClass:(Class)toViewController
{
	self = [super init];
	if (self) {
		_fromViewControllerClass = fromViewController;
		_toViewControllerClass = toViewController;
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	SwipeUniqueTransition *copiedObject = [[[self class] allocWithZone:zone] init];
	
	copiedObject.toViewControllerClass = self.toViewControllerClass;
	copiedObject.fromViewControllerClass = self.fromViewControllerClass;
	
	return copiedObject;
}

- (NSUInteger)hash
{
	return [[self fromViewControllerClass] hash] ^ [[self toViewControllerClass] hash];
}

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[SwipeUniqueTransition class]]) {
		return NO;
	}
	
	SwipeUniqueTransition *otherObject = (SwipeUniqueTransition *)object;
	
	return (otherObject.fromViewControllerClass == self.fromViewControllerClass) &&
	(otherObject.toViewControllerClass == self.toViewControllerClass);
}


@end
