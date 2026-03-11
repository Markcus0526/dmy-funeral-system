//
//  LingDaoYeJiVC.m
//  BinZang
//
//  Created by KimOkChol on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZhuRenDaiXiaoShangYeJiVC.h"
#import "MJRefresh.h"

#pragma mark - ZhuRenYeJiCell
@interface ZhuRenYeJiCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *score;
@end

@implementation ZhuRenYeJiCell
- (void) setScoreData : (STAgentScore_Manager*)data
{
	borderWidthColor(_name, 0.5, [UIColor blackColor]);
	borderWidthColor(_score, 0.5, [UIColor blackColor]);
	
	_name.text = data.user_name;
	_score.text = [NSString stringWithFormat:@"%ld", (long)data.score];
}
@end

#pragma mark - LingDaoYeJiVC

@interface ZhuRenDaiXiaoShangYeJiVC ()
{
	NSMutableArray *	arrItems;
	int					nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}

@property (weak, nonatomic) IBOutlet UITableView *tblList;
@property (weak, nonatomic) IBOutlet UIView *vwHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

@end

@implementation ZhuRenDaiXiaoShangYeJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void) viewWillAppear:(BOOL)animated
{
	[_tblList layoutIfNeeded];
	if (!listEmptyView)
	{
		listEmptyView = [[MIListEmptyView alloc] initWithFrame:_tblList.frame];
		[self.view addSubview:listEmptyView];
	}
}
//- (void) viewWillAppear:(BOOL)animated
//{
//	[arrItems removeAllObjects];
//	
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Basic Function

- (void) initControls
{
	nCurPageNo = 0;
	
	borderWidthColor(_lblName, 0.5, [UIColor blackColor]);
	borderWidthColor(_lblScore, 0.5, [UIColor blackColor]);
	
	// setup pull to refresh
	[self setupTableRefresh];
	
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self callGetData:nCurPageNo];
	
	self.navigationItem.title = @"代销业绩";
}


#pragma mark - Pull refresh event

- (void)setupTableRefresh
{
	// 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
	[_tblList addFooterWithTarget:self action:@selector(footerRereshing)];
	
	// 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
	_tblList.footerPullToRefreshText = MSG_TBLFOOTER_PULL;
	_tblList.footerReleaseToRefreshText = MSG_TBLFOOTER_RELEASE;
	_tblList.footerRefreshingText = MSG_TBLFOOTER_REFRESHING;
}

- (void)footerRereshing
{
	nCurPageNo = (int)[arrItems count] / PAGE_COUNT;
	[self callGetData:nCurPageNo];
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
	[_tblList reloadData];
	
	// stop refreshing
	[_tblList footerEndRefreshing];
}

- (bool) inDataList:(STAgentScore_Manager *)object orglen:(long)orglen
{
	STAgentScore_Manager *task;
	for (long j = 0; j < orglen; j++)
	{
		task = [arrItems objectAtIndex:j];
		if (object.user_id == task.user_id)
			return YES;
	}
	
	return NO;
}

- (void) addResult:(NSMutableArray *)objList
{
	STAgentScore_Manager *new;
	
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

- (void) callGetData : (int)pageno
{
	[self callGetAgentPersonalScoreMgr:pageno];
}

/**
 * call get bill list service
 */
- (void) callGetAgentPersonalScoreMgr : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetAgentPersonalScoreMgr:pageno];
}

- (void) GetAgentPersonalScoreMgrResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return _vwHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return arrItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	ZhuRenYeJiCell *cell = (ZhuRenYeJiCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	[cell setScoreData:[arrItems objectAtIndex:indexPath.row]];
	 
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

@end
