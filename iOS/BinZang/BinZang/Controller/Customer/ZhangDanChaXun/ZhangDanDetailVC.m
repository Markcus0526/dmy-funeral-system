//
//  ZhangDanDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZhangDanDetailVC.h"

@implementation BillDetProductTableCell
@end

@interface ZhangDanDetailVC ()

@end

#define CELL_ID						@"cellBillDetProd"
#define CELL_HEIGHT					25

@implementation ZhangDanDetailVC

@synthesize mBillInfo;

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
	[self callGetDetailInfo];
}

/**
 * update UI
 */
- (void) updateUI
{
	// set first area
	[_lblBillType setText:mBillInfo.type];
	[_lblBuyTime setText:mBillInfo.buy_time];
	[_lblName setText:mBillInfo.name];
	[_lblServeType setText:mBillInfo.service_type];
	[_lblServePrice setText:mBillInfo.service_price_desc];
	
	// set second area
	[_tblProducts reloadData];
	[_lblTotalMoney setText:mBillInfo.total_amount_desc];
	_constProdHeight.constant = CELL_HEIGHT * mBillInfo.products.count;
	
	// set third area
	[_lblUseTime setText:mBillInfo.consume_time];
	[_lblState setText:mBillInfo.state_desc];
	[_txtRemark setText:mBillInfo.remark];
	_constRemarkHeight.constant = _txtRemark.contentSize.height;
	
	[self.view layoutIfNeeded];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get qingren list service
 */
- (void) callGetDetailInfo
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetBillDetail:mBillInfo.uid];
}

- (void) getBillDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STBill *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mBillInfo = datainfo;
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
	if (mBillInfo.products == nil) {
		return 0;
	}
	
	return mBillInfo.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	BillDetProductTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STProduct * datainfo = (STProduct *)[mBillInfo.products objectAtIndex:indexPath.row];
	[cell.lblContents setText:[NSString stringWithFormat:@"%@(%d) %@", datainfo.title, datainfo.amount, datainfo.price_desc]];
	
	return cell;
}


@end
