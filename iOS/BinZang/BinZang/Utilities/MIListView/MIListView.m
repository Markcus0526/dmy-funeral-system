//
//  MIListView.m
//  BinZang
//
//  Created by KimOkChol on 5/8/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIListView.h"

#pragma mark - MIListViewItem

@interface MIListViewItem()
{
	long item_count;
	NSMutableArray *arrSubViews;
	NSArray *arrWidths;
}
@end

@implementation MIListViewItem

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	item_count = 0;
	
	return self;
}

- (void) layoutFrame :(int) height widths:(NSArray*)widths
{
	int width = 0;
	
	arrSubViews = [[NSMutableArray alloc] init];
	arrWidths = widths;
	
	CGRect frame = CGRectMake(0, 0, 0, height);
	UILabel *sepeator, *label;
	
	item_count = widths.count;
	long index = 0;
	for (NSNumber *number in widths)
	{
		width = [number intValue];
		
		frame.origin.x += frame.size.width;
		frame.size.width = width;
		
		label = [[UILabel alloc] initWithFrame:frame];
		label.textAlignment = NSTextAlignmentCenter;
		label.numberOfLines = 2;
		
		[self addSubview:label];
		[arrSubViews addObject:label];
		
		if (index < item_count)
		{
			sepeator = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, 0, 1, height)];
			sepeator.backgroundColor = [UIColor blackColor];
			[self addSubview:sepeator];
		}
		index ++;
	}
	borderWidthColor(self, 0.5, [UIColor blackColor]);
}

- (void) setText : (NSArray *)texts
{
	NSString *string;
	UILabel *label;
	if (texts.count < item_count)
		item_count = texts.count;
	
	for (long index = 0; index < item_count; index++)
	{
		string = [texts objectAtIndex:index];
		label = [arrSubViews objectAtIndex:index];
		
		label.text = string;
	}
}

@end

#pragma mark - MIListView

@interface MIListView()
{
	NSMutableArray *reuseItems;
	NSMutableArray *visibleItems;

	CGFloat			contentHeight;
	CGFloat			contentWidth;
	
	CGFloat			rowHeight;
	CGFloat			rowWidth;
	NSArray*		columnWidths;
	
	NSInteger		sections;
}
@end

@implementation MIListView

@synthesize delegate;
@synthesize dataSource;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init
{
	self = [super init];
	[self initControls];
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	[self initControls];
	
	return self;
}

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	[self initControls];
	
	return self;
}

// Private Functions
- (void) initControls
{
	sections = 1;
	
	reuseItems = [[NSMutableArray alloc] init];
	visibleItems = [[NSMutableArray alloc] init];
}

- (UIView*) reuseView
{
	if (reuseItems.count > 0)
	{
		UIView * view;
		view = [reuseItems objectAtIndex:0];
		[reuseItems removeObject:view];
		
		[visibleItems addObject:view];
		return view;
	}
	
	MIListViewItem *view = [[MIListViewItem alloc] init];
	
	[view layoutFrame:rowHeight widths:columnWidths];

	[visibleItems addObject:view];
	return view;
}

- (void) resetAllSubViews
{
	for (UIView *view in visibleItems)
	{
		[view removeFromSuperview];
		[reuseItems addObject:view];
	}
	
	[visibleItems removeAllObjects];
}

- (void) relayout
{
	//remove all subviews
	contentHeight = 0;
	contentWidth = 0;
	
	CGRect frame = CGRectMake(0, 0, rowWidth, rowHeight);

	contentWidth = rowWidth;
	
	for (long sec = 0; sec < sections ; sec++)
	{
		NSInteger nRows = [dataSource listView:self numberOfRowAtSection:sec];
		
		for (NSInteger row = 0; row < nRows ; row++)
		{
			NSArray *arrTexts = [dataSource listView:self textsAtIndexPath:[NSIndexPath indexPathForItem:row inSection:sec]];
			
			MIListViewItem *view = (MIListViewItem*)[self reuseView];
			
			frame.origin.y = contentHeight;
			
			view.frame = frame;
			[view setText:arrTexts];
			
			[self addSubview:view];
			
			contentHeight += rowHeight;
		}
	}
	
	self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

//Public functions

- (void) reloadData
{
	CGFloat nHeight = [dataSource rowHeight:self];
	CGFloat nWidth = [dataSource rowWidth:self];
	
	if (dataSource && [dataSource respondsToSelector:@selector(numberOfSection:)])
		sections = [dataSource numberOfSection:self];
	
	NSArray * nWidths = [dataSource columnWidths:self];
	
	[self resetAllSubViews];
	
	if (nHeight != rowHeight || nWidth != rowWidth || nWidths != columnWidths)
	{
		rowWidth = nWidth;
		rowHeight = nHeight;
		columnWidths = nWidths;
		[reuseItems removeAllObjects];
	}
	
	[self relayout];
}
@end
