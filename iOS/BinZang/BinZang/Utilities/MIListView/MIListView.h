//
//  MIListView.h
//  BinZang
//
//  Created by KimOkChol on 5/8/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MIListViewDataSource;
@protocol MIListViewDelegate;

#pragma mark - MIListViewItem definition

@interface MIListViewItem : UIView
- (void) setText : (NSArray *)texts;
@end


#pragma mark - MIListView definition

@interface MIListView : UIScrollView

@property (nonatomic, assign)   id <MIListViewDataSource> dataSource;
@property (nonatomic, assign)   id <MIListViewDelegate>   delegate;

- (void) reloadData;
@end


#pragma mark - MIListViewDataSource definition

@interface NSIndexPath (MIListView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property(nonatomic,readonly) NSInteger section;
@property(nonatomic,readonly) NSInteger row;

@end

@protocol MIListViewDataSource <NSObject>

@required

- (NSInteger)listView:(MIListView *)listView numberOfRowAtSection:(NSInteger)section;

//for cell
- (NSInteger) numberOfColumn:(MIListView *)listView;
- (CGFloat) rowHeight:(MIListView *)listView;
- (CGFloat) rowWidth:(MIListView *)listView;
- (NSArray *) columnWidths:(MIListView *)listView;

- (NSArray *) listView:(MIListView *)listView textsAtIndexPath:(NSIndexPath*)indexPath;

// Variable height support



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

//for customize view
//- (MIListViewItem *)listView:(MIListView *)listView viewForRow:(long)row;

@optional
- (NSInteger)numberOfSection:(MIListView *)listView ;

@end

#pragma mark - MIListViewDelegate definition

@protocol MIListViewDelegate<NSObject, UIScrollViewDelegate>

@optional

// Display customization

- (void)listView:(MIListView *)listView willDisplayRow:(MIListViewItem *)view forIndexPath:(NSIndexPath*)indexPath;
- (void)listView:(MIListView *)listView didEndDisplayingRow:(MIListViewItem *)cell forIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)listView:(MIListView *)listView willSelectRowIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath *)listView:(MIListView *)listView willDeselectRowIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(3_0);
// Called after the user changes the selection.
- (void)listView:(MIListView *)listView didSelectRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)listView:(MIListView *)listView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(3_0);

@end


