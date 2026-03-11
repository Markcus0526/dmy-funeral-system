//
//  QingRenShuJuVC.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "QingRenShuJuVC.h"

@implementation QingRenTableCell
@end

@interface QingRenShuJuVC ()
{
	NSMutableArray *			arrItems;
}

@end


#define CELL_ID					@"cellQingRen"
#define CELL_HEIGHT				135

@implementation QingRenShuJuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
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


///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	[self callGetItemlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
	arrItems = newItems;
	[_tblItems reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get qingren list service
 */
- (void) callGetItemlist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetRelativeData];
}

- (void) getRelativeDataResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self updateUI:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if (arrItems == nil) {
		return 0;
	}
	
	return arrItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	QingRenTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STRelative * datainfo = (STRelative *)[arrItems objectAtIndex:indexPath.row];
	[cell.lblRelative setText:[NSString stringWithFormat:@"%@ : %@", datainfo.relative, datainfo.name]];
	[cell.lblArea setText:datainfo.area_no];
	[cell.lblBirthday setText:datainfo.birthday];
	[cell.lblDeathday setText:datainfo.deathday];
	
	return cell;
}


@end
