//
//  MIListEmptyView.m
//  BinZang
//
//  Created by KimOkChol on 5/19/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIListEmptyView.h"

@implementation MIListEmptyView

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	[self initView];
	return self;
}

- (void) initView
{
	//self.backgroundColor = [UIColor grayColor];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	label.textAlignment = NSTextAlignmentCenter;
	label.text = @"暂时没有信息...";
	//label.backgroundColor = [UIColor lightGrayColor];
	[self addSubview:label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
