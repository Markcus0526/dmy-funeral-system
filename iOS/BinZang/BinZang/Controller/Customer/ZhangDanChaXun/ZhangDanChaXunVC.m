//
//  ZhangDanChaXunVC.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZhangDanChaXunVC.h"
#import "ZhangDanDetailVC.h"
#import "MJRefresh.h"

@implementation ZhangDanTableCell
@end

@interface ZhangDanChaXunVC ()
{
	NSMutableArray *			arrItems;
	int							nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}
@end

#define CELL_ID						@"cellBill"
#define CELL_HEIGHT					95
#define SEGUE_TO_DETAIL				@"segueFromCusZhangDanToDetail"

@implementation ZhangDanChaXunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
	[_tblItems layoutIfNeeded];
	if (!listEmptyView)
	{
		listEmptyView = [[MIListEmptyView alloc] initWithFrame:_tblItems.frame];
		[self.view addSubview:listEmptyView];
	}
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
		STBill * datainfo = (STBill *)[arrItems objectAtIndex:button.tag];
		// set data
		ZhangDanDetailVC * destCtrl = (ZhangDanDetailVC *)segue.destinationViewController;
		destCtrl.mBillInfo = datainfo;
	}
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	nCurPageNo = 0;
	
	//_tblItems.separatorStyle = UITableViewCellSeparatorStyleNone;
	// setup pull to refresh
	[self setupTableRefresh];
	
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self callGetBillList:nCurPageNo];
}


#pragma mark - Pull refresh event

- (void)setupTableRefresh
{
	// 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
	[_tblItems addFooterWithTarget:self action:@selector(footerRereshing)];
	
	// 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
	_tblItems.footerPullToRefreshText = MSG_TBLFOOTER_PULL;
	_tblItems.footerReleaseToRefreshText = MSG_TBLFOOTER_RELEASE;
	_tblItems.footerRefreshingText = MSG_TBLFOOTER_REFRESHING;
}

- (void)footerRereshing
{
	nCurPageNo = (int)[arrItems count] / PAGE_COUNT;
	[self callGetBillList:nCurPageNo];
}


/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
	if([newItems count] > 0)
	{
		if (arrItems == nil)
		{
			arrItems = newItems;
		}
		else
		{
			[self addResult:newItems];
		}
	}
	
	if (!arrItems || arrItems.count <= 0)
	{
		listEmptyView.hidden = NO;
	}else
		listEmptyView.hidden = YES;
	
	[_tblItems reloadData];
	
	// stop refreshing
	[_tblItems footerEndRefreshing];
}

- (bool) inDataList:(STBill *)object orglen:(long)orglen
{
	STBill *task;
	for (long j = 0; j < orglen; j++)
	{
		task = [arrItems objectAtIndex:j];
		if (object.uid == task.uid)
			return YES;
	}
	
	return NO;
}

- (void) addResult:(NSMutableArray *)objList
{
	STBill *new;
	
	long objlength = [objList count];
	long orglength = [arrItems count];
	
	for (long i = 0; i < objlength; i++)
	{
		new = [objList objectAtIndex:i];
		if (![self inDataList:new orglen:orglength])
		{
			[arrItems addObject:new];
		}
	}
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get bill list service
 */
- (void) callGetBillList : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetBills:pageno];
}

- (void) getBillsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
	ZhangDanTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STBill * datainfo = (STBill *)[arrItems objectAtIndex:indexPath.row];
	[cell.lblName setText:datainfo.name];
	[cell.lblTime setText:datainfo.buy_time];
	[cell.lblMoney setText:datainfo.total_amount_desc];
	[cell.btnMain setTag:indexPath.row];
	
	return cell;
}


@end
