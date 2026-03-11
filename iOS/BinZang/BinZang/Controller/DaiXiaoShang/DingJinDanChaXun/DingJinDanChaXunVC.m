//
//  DingJinDanChaXunVC.m
//  BinZang
//
//  Created by KimOkChol on 4/29/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "DingJinDanChaXunVC.h"
#import "MJRefresh.h"

@interface DingJinDanCell()
@property (weak, nonatomic) IBOutlet UIView *vwFrame;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTombID;
@property (weak, nonatomic) IBOutlet UILabel *lblReciever;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

-(void) setDepositLog:(STDepositLog*)log;
@end


@implementation DingJinDanCell

-(void) setDepositLog:(STDepositLog*)log
{
	borderWidthColor(_vwFrame, 0.5, [UIColor darkGrayColor]);
	_lblStartDate.text = log.start_time;
	_lblEndDate.text = log.end_time;
	_lblName.text = log.name;
	_lblTombID.text = log.tomb_no;
	_lblReciever.text = log.receiver;
	_lblPrice.text = log.price_desc;
}

@end

@interface DingJinDanChaXunVC ()
{
	NSMutableArray *			arrItems;
	int							nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@end

#define CELL_ID						@"cell"

@implementation DingJinDanChaXunVC

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
	nCurPageNo = 0;
	
	// setup pull to refresh
	[self setupTableRefresh];
	
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self callGetDepositList:nCurPageNo];
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
	[self callGetDepositList:nCurPageNo];
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

- (bool) inDataList:(STDepositLog *)object orglen:(long)orglen
{
	STDepositLog *task;
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
	STDepositLog *new;
	
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
- (void) callGetDepositList : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetDepositLogs:[[Common strUserId] integerValue] page_no:pageno];
}

- (void) getDepositLogsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	DingJinDanCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STDepositLog * datainfo = (STDepositLog *)[arrItems objectAtIndex:indexPath.row];
	
	[cell setDepositLog:datainfo];
	
	return cell;
}


@end
