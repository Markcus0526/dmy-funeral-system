//
//  LingDaoDingJinDanVC.m
//  BinZang
//
//  Created by KimOkChol on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingDaoDingJinDanVC.h"
#import "MJRefresh.h"

#pragma mark - LingDaoYeJiCell
@interface LingDaoDingJinDanCell()
@property (weak, nonatomic) IBOutlet UILabel *lblOfficeName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice1;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice2;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice3;

@end

@implementation LingDaoDingJinDanCell
- (void) setData : (STOfficeDepositLog*)data
{
	_lblOfficeName.text = data.office_name;
	_lblPrice1.text = [NSString stringWithFormat:@"自营订金 ： %ld", (long)data.employee];
	_lblPrice2.text = [NSString stringWithFormat:@"代销商订金 ： %ld", (long)data.agent];
	_lblPrice3.text = [NSString stringWithFormat:@"总订金 ： %ld", (long)data.total];
}
@end


@interface LingDaoDingJinDanVC ()
{
	NSMutableArray *	arrItems;
	int					nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}
@property (weak, nonatomic) IBOutlet UITableView *tblList;

@end

@implementation LingDaoDingJinDanVC

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
	[_tblList layoutIfNeeded];
	if (!listEmptyView)
	{
		listEmptyView = [[MIListEmptyView alloc] initWithFrame:_tblList.frame];
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

#pragma mark - Basic Function

- (void) initControls
{
	nCurPageNo = 0;
	
	// setup pull to refresh
	[self setupTableRefresh];
	
	[self callGetData:nCurPageNo];
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

- (bool) inDataList:(STOfficeDepositLog *)object orglen:(long)orglen
{
	STOfficeDepositLog *task;
	for (long j = 0; j < orglen; j++)
	{
		task = [arrItems objectAtIndex:j];
		if (object.uid == task.uid && object.office_id == task.office_id)
			return YES;
	}
	
	return NO;
}

- (void) addResult:(NSMutableArray *)objList
{
	STOfficeDepositLog *new;
	
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
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self callGetOfficeDepositLogs:pageno];
}

/**
 * call get bill list service
 */
- (void) callGetOfficeDepositLogs : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficesDepositLogs:pageno];
}

- (void) GetOfficesDepositLogsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
	return arrItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	LingDaoDingJinDanCell *cell = (LingDaoDingJinDanCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	[cell setData:[arrItems objectAtIndex:indexPath.row]];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

@end
