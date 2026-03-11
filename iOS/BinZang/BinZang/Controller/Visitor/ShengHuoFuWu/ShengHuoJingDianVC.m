//
//  ShengHuoJingDianVC.m
//  BinZang
//
//  Created by KimOkChol on 4/18/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoJingDianVC.h"
#import "ShengHuoJingDianDetailVC.h"


@implementation JingDianTableCell1
@end

@interface ShengHuoJingDianVC ()
{
	NSMutableArray *			arrViews;
}
@end

#define CELL_ID					@"cellJingDian"
#define CELL_HEIGHT				100
#define SEGUE_TO_DETAIL			@"segueFromJingDianToDetail"

@implementation ShengHuoJingDianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
	{
		// get current office data
		UIButton * button = (UIButton *)sender;
		STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:button.tag];
		// set data
		ShengHuoJingDianDetailVC * destCtrl = (ShengHuoJingDianDetailVC *)segue.destinationViewController;
		destCtrl.mDetailInfo = datainfo;
	}
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	[self callGetJingDianlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems
{
	arrViews = arrItems;
	[_tblJingDian reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get office list service
 */
- (void) callGetJingDianlist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetMtQiPanViews];
}

- (void) getMtQiPanViewsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
	if (arrViews == nil) {
		return 0;
	}
	
	return arrViews.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	JingDianTableCell1 * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[JingDianTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:indexPath.row];
	[cell.lblTitle setText:datainfo.title];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
	borderWidthColor(cell.imgMain, 1, [UIColor grayColor]);
	[cell.txtAddress setText:datainfo.address];
	[cell.lblPhone setText:datainfo.phone];
	[cell.btnAddress setTag:indexPath.row];
	[cell.btnPhone setTag:indexPath.row];
	[cell.btnMain setTag:indexPath.row];
	
	return cell;
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1)
	{
		STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:alertView.tag];
		// go to address navigation
	}
	
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction Relation

- (IBAction)onTapAddress:(id)sender
{
	UIButton * button = (UIButton *)sender;
	
	// show alert view
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_GOTO_ADDRESS delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
	[alert setTag:button.tag];
	[alert show];
}

- (IBAction)onTapPhone:(id)sender
{
	UIButton * button = (UIButton *)sender;
	STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:button.tag];
	
	[GlobalFunc callPhone:datainfo.phone];
}


@end
