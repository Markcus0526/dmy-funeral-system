//
//  JiBaiYongPinVC.m
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "JiBaiYongPinVC.h"

@implementation WorshipItemTableCell
@end

@interface JiBaiYongPinVC ()
{
	NSMutableArray *			arrItems;
	NSMutableArray *			arrDatalist;
	
	enum EN_PROD_TYPE 			enCurType;

	int							height;
}
@property (weak, nonatomic) IBOutlet UIButton *chkType1;
@property (weak, nonatomic) IBOutlet UIButton *chkType2;
@property (weak, nonatomic) IBOutlet UIButton *chkType3;
@property (weak, nonatomic) IBOutlet UIButton *chkType4;
@end


#define CELL_HEIGHT				220
#define CELL_ID					@"cellWorshipItem"

@implementation JiBaiYongPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
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



- (NSMutableArray *) getItemsByType : (enum EN_PROD_TYPE)type
{
	NSMutableArray * items = [[NSMutableArray alloc] init];
	for (STProduct * one in arrDatalist) {
		if (one.type == type) {
			[items addObject:one];
		}
	}
	
	return items;
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction

- (IBAction)onTapType1:(id)sender
{
	enCurType = PROD_TYPE1;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:YES];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType2:(id)sender
{
	enCurType = PROD_TYPE2;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:YES];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType3:(id)sender
{
	enCurType = PROD_TYPE3;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:YES];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType4:(id)sender
{
	enCurType = PROD_TYPE4;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:YES];
	
	[_tblItems reloadData];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function


/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrData;
{
	enCurType = PROD_TYPE1;
	[_tblItems layoutIfNeeded];
	
	CGRect frame = _tblItems.frame;
	
	height = 80 + (frame.size.width - 20 - 20) / 2;

	arrDatalist = arrData;
	
	arrItems = [self getItemsByType:enCurType];
	[_tblItems reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if (arrDatalist == nil) {
		return 0;
	}
	
	return arrItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	WorshipItemTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[WorshipItemTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	STProduct * datainfo = (STProduct *)[arrItems objectAtIndex:indexPath.row];
	[cell.lblTitle setText:datainfo.title];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
	
	return cell;
}


@end
