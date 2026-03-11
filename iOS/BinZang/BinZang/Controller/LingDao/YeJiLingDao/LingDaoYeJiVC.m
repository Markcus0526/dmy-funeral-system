//
//  LingDaoYeJiVC.m
//  BinZang
//
//  Created by KimOkChol on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingDaoYeJiVC.h"
#import "MJRefresh.h"
#import "MIListEmptyView.h"

#pragma mark - LingDaoYeJiCell
@interface LingDaoYeJiCell()
@property (weak, nonatomic) IBOutlet UILabel *office;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *score;
@end

@implementation LingDaoYeJiCell
- (void) setScoreData : (STScore*)data
{
	borderWidthColor(_office, 0.5, [UIColor blackColor]);
	borderWidthColor(_name, 0.5, [UIColor blackColor]);
	borderWidthColor(_score, 0.5, [UIColor blackColor]);
	
	_office.text = data.office_name;
	_name.text = data.user_name;
	_score.text = [NSString stringWithFormat:@"%ld", (long)data.score];
}
@end

#pragma mark - LingDaoYeJiVC

@interface LingDaoYeJiVC ()
{
	NSMutableArray *	arrItems;
	int					nCurPageNo;
	MIListEmptyView		*listEmptyView;
}

@property (weak, nonatomic) IBOutlet UITableView *tblList;

@property (weak, nonatomic) IBOutlet UIView *vwHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblOffice;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

@end

@implementation LingDaoYeJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
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

- (void) viewWillAppear:(BOOL)animated
{
	[_tblList layoutIfNeeded];
	if (!listEmptyView)
	{
		listEmptyView = [[MIListEmptyView alloc] initWithFrame:_tblList.frame];
		[self.view addSubview:listEmptyView];
	}
}
#pragma mark - Basic Function

- (void) initControls
{
	nCurPageNo = 0;
	
	borderWidthColor(_lblOffice, 0.5, [UIColor blackColor]);
	borderWidthColor(_lblName, 0.5, [UIColor blackColor]);
	borderWidthColor(_lblScore, 0.5, [UIColor blackColor]);
	
	// setup pull to refresh
	[self setupTableRefresh];
	
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self callGetData:nCurPageNo];
	
	self.navigationItem.title = _isEmployee?@"个人业绩":@"代销业绩";
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

- (bool) inDataList:(STScore *)object orglen:(long)orglen
{
	STScore *task;
	for (long j = 0; j < orglen; j++)
	{
		task = [arrItems objectAtIndex:j];
		if (object.user_id == task.user_id && object.office_id == task.office_id)
			return YES;
	}
	
	return NO;
}

- (void) addResult:(NSMutableArray *)objList
{
	STScore *new;
	
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
	if (_isEmployee)
		[self callGetEmployeePersonalScore:pageno];
	else
		[self callGetAgentPersonalScore];
}

/**
 * call get bill list service
 */
- (void) callGetEmployeePersonalScore : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetEmployeePersonalScore:pageno];
}

- (void) GetEmployeePersonalScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (void) callGetAgentPersonalScore
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetAgentPersonalScore];
}

- (void) GetAgentPersonalScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
	LingDaoYeJiCell *cell = (LingDaoYeJiCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	[cell setScoreData:[arrItems objectAtIndex:indexPath.row]];
	 
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

@end
