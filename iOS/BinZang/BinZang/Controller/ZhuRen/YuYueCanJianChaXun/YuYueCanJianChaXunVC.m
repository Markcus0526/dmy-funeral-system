//
//  YuYueCanJianChaXunVC.m
//  BinZang
//
//  Created by KimOkChol on 5/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "YuYueCanJianChaXunVC.h"
#import "MJRefresh.h"
#import "MIConfirmViewController.h"

@class YuYueCanJianChaXunVC;

#pragma mark - YuYueCanJianCell
@interface YuYueCanJianCell()
{
	YuYueCanJianChaXunVC *parent;
	STReserveLog *manilog;
}
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIView *vwButton;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;

@end

@implementation YuYueCanJianCell

- (void) initControls
{
	borderWidthColor(_vwMain, 0.5, [UIColor blackColor]);
	
	roundRect(_btnCancel, DEF_CORNER_RADIO);
	roundRect(_btnOK, DEF_CORNER_RADIO);
	
	if (log && manilog.state)
	{
		_constraintHeight.constant = 0;
		_vwButton.hidden = YES;
	}else{
		_constraintHeight.constant = 40;
		_vwButton.hidden = NO;
	}
}

- (void) setData:(STReserveLog*)data parent:(UIViewController*)parent_
{
	manilog = data;
	parent = (YuYueCanJianChaXunVC*)parent_;
	
	[self initControls];
	
	_lblName.text = [NSString stringWithFormat:@"客户名称 ： %@", data.customer_name];
	
	_lblPhone.text = [NSString stringWithFormat:@"客户电话 ： %@", data.customer_phone];
	
	_lblDate.text = [NSString stringWithFormat:@"预约时间 ： %@", data.reserve_date];

	_lblState.text = data.state_desc;
}

- (IBAction)onOK:(id)sender
{
	[parent ConfirmReserve:self.tag log:manilog];
}

- (IBAction)onCancel:(id)sender
{
	[parent CancelReserve:self.tag log:manilog];
}

@end

@interface YuYueCanJianChaXunVC ()<MIConfirmDelegate>
{
	BOOL				bReserveOK;
	long				log_index;
	STReserveLog		*mani_log;
	
	NSMutableArray *	arrItems;
	int					nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}
@property (weak, nonatomic) IBOutlet UITableView *tblList;
@end

@implementation YuYueCanJianChaXunVC

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

- (bool) inDataList:(STReserveLog *)object orglen:(long)orglen
{
	STReserveLog *task;
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
	STReserveLog *new;
	
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

- (void) onConfirmOK
{
	long log_id = mani_log.uid;
	
	if (bReserveOK)
	{
		[self CallConfirmReserve:log_id];
	}else{
		[self CallCancelReserve:log_id];
	}
	
	[self hideConfirmView];
}

- (void) onConfirmCancel
{
	[self hideConfirmView];
}

- (void) CancelReserve : (long)index log:(STReserveLog*)log
{
	bReserveOK = NO;
	log_index = index;
	mani_log = log;
	
	[self showConfirmView:@"您确定要取消该参见申请吗?"];
}

- (void) ConfirmReserve : (long)index log:(STReserveLog*)log
{
	bReserveOK = YES;
	log_index = index;
	mani_log = log;
	
	[self showConfirmView:@"您确定要确认该参见申请吗?"];
}

- (void) showConfirmView : (NSString*)message
{
	MIConfirmViewController *confVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MIConfirmViewController"];
	
	[self addChildViewController:confVC];
	[self.view addSubview:confVC.view];
	confVC.delegate = self;
	[confVC setMessage:message];
	[confVC didMoveToParentViewController:self];
}

- (void) hideConfirmView
{
	[self willMoveToParentViewController:nil];
}
///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

- (void) callGetData : (int)pageno
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	[self GetReserveLogs:pageno];
}

/**
 * call get bill list service
 */
- (void) GetReserveLogs : (int)pageno
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetReserveLogs:pageno];
}

- (void) getReserveLogsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (void) CallCancelReserve : (long)log_id
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];

	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] cancelReserve:log_id];
}

- (void) cancelReserveResult	: (NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:retmsg afterDelay:DEF_DELAY];
		mani_log.state = 2;
		mani_log.state_desc = @"已取消";
		[self changedStatus:log_index];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) CallConfirmReserve : (long)log_id
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];

	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] confirmReserve:log_id];
}

- (void) confirmReserveResult	: (NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:retmsg afterDelay:DEF_DELAY];
		mani_log.state = 1;
		mani_log.state_desc = @"已确认";
		[self changedStatus:log_index];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

-(void) changedStatus : (NSInteger)row
{
	NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]];
	
	[_tblList beginUpdates];
	[_tblList deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
	[_tblList insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
	[_tblList endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return arrItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	YuYueCanJianCell *cell = (YuYueCanJianCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	[cell setData:[arrItems objectAtIndex:indexPath.row] parent:self];
	cell.tag = indexPath.row;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	STReserveLog *log = [arrItems objectAtIndex:indexPath.row];
	
	return log.state?90:130;
}

@end
