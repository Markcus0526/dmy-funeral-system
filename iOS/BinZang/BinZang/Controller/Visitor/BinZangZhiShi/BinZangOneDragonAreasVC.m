//
//  BinZangOneDragonAreasVC.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BinZangOneDragonAreasVC.h"
#import "BinZangOneDragonDetailVC.h"

@implementation DragonAreaTableCell
@end

@interface BinZangOneDragonAreasVC ()
{
	NSMutableArray *			arrAreas;
	STDragonServiceArea *		areaDetInfo;
}
@end

#define CELL_ID						@"cellDragonArea"
#define CELL_HEIGHT					120
#define SEGUE_TO_DETAIL				@"segueFromDragonAreaToDetail"

@implementation BinZangOneDragonAreasVC

@synthesize nAreaId;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
	{
		// get current office data
		UIButton * button = (UIButton *)sender;
		STDragonServiceArea * datainfo = (STDragonServiceArea *)[arrAreas objectAtIndex:button.tag];
		// set data
		BinZangOneDragonDetailVC * destCtrl = (BinZangOneDragonDetailVC *)segue.destinationViewController;
		destCtrl.nServiceId = datainfo.uid;
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	[self callGetSvcArealist];
}

/**
 * update UI
 */
- (void) updateUI
{
	arrAreas = areaDetInfo.services;
	[_lblName setText:areaDetInfo.name];
	
	[_tblAreas reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get service area list service
 */
- (void) callGetSvcArealist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOneDragonAreaDetail:nAreaId];
}

- (void) getOneDragonAreaDetResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDragonServiceArea *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		areaDetInfo = datainfo;
		[self updateUI];
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
	if (arrAreas == nil) {
		return 0;
	}
	
	return arrAreas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	DragonAreaTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[DragonAreaTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	STDragonService * datainfo = (STDragonService *)[arrAreas objectAtIndex:indexPath.row];
	[cell.lblNo setText:[NSString stringWithFormat:@"%ld", indexPath.row + 1]];
	[cell.lblTitle setText:datainfo.name];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
	borderWidthColor(cell.imgMain, 1, [UIColor grayColor]);
	[cell.lblContents setText:datainfo.intro];
	[cell.lblPrice setText:datainfo.price_desc];
	[cell.lblRate setText:[NSString stringWithFormat:@"%d", datainfo.user_agree_rate]];
	[cell.btnMain setTag:indexPath.row];
	
	return cell;
}


@end
