//
//  DingJinDanChaXunVC_YG.m
//  BinZang
//
//  Created by Beids on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "DingJinDanChaXunVC_YG.h"
#import "MinXiBiaoVC.h"
#import "MJRefresh.h"

#define CELL_ID						@"cell"
#define CELL_HEIGHT					140

#define SEGUE_TO_MINXIBIAO				@"segueFromDingJinDanToMingXiBiao"

@interface DingJinDanCell_YG ()
-(void) setDepositLog:(STDepositLog*)log;
@end
@implementation DingJinDanCell_YG

-(void) setDepositLog:(STDepositLog*)log
{
    borderWidthColor(_vwFrame, 1, [UIColor darkGrayColor]);
    _lblStartDate.text = log.start_time;
    _lblEndDate.text = log.end_time;
    _lblName.text = log.name;
    _lblTombID.text = log.tomb_no;
    _lblReciever.text = log.receiver;
    _lblPrice.text = log.price_desc;
}

@end

@interface DingJinDanChaXunVC_YG ()
{
    NSMutableArray *			arrItems;
    int							nCurPageNo;
    BOOL                        bCallingService;
	
	MIListEmptyView		*listEmptyView;
}
@end

@implementation DingJinDanChaXunVC_YG

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

- (void) initControls
{
    nCurPageNo = 0;
    bCallingService = false;
    
    // setup pull to refresh
    [self setupTableRefresh];
    
	if (self.isOwnDingJinDan)
	{
		self.employee_id = [Common userInfo].uid;

		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0, 0, 90, 35);
		button.layer.borderColor = [UIColor whiteColor].CGColor;
		button.layer.borderWidth = 1.0f;
		button.layer.cornerRadius = 4;
		[button addTarget:self action:@selector(OnMingXiBiao:) forControlEvents:UIControlEventTouchUpInside];
		[button setTitle:@"明细表" forState:UIControlStateNormal];
		//button.layer.
		
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
		//self.navigationController.
		//self.toolBar.items = @[backButton];
		
		//UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"                                                                    style:UIBarButtonItemStyleDone target:nil action:nil];
		self.navigationItem.rightBarButtonItem = rightButton;
	}
    // show HUB first time
    
    [self callGetDepositList:nCurPageNo];
	
	
    /*
    UIView* itemview = (UIView*)_item;
    itemview.layer.borderWidth = 1;
    itemview.layer.borderColor = [[UIColor colorWithRed:1 green:1 blue:153.f/255 alpha:1] CGColor];*/
}

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
        //if (arrItems != nil)
        
        arrItems = newItems;
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
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    bCallingService = true;
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetDepositLogs:self.employee_id page_no:pageno];
}

- (void) callAgentGetDepositList : (int)pageno
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    bCallingService = true;
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetAgentDepositLogs:self.employee_id page_no:pageno];
}

- (void) getDepositLogsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
    bCallingService = false;
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
    DingJinDanCell_YG * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STDepositLog * datainfo = (STDepositLog *)[arrItems objectAtIndex:indexPath.row];
    
    [cell setDepositLog:datainfo];
    
    return cell;
}

- (IBAction)OnZhiYing:(id)sender {
    if ( !_btnZhiYing.isSelected && !bCallingService)
    {
        [_btnZhiYing setSelected:YES];
        [_btnDiaXiaoShang setSelected:NO];
        
        [arrItems removeAllObjects];
        [_tblItems reloadData];
        
        [self callGetDepositList:nCurPageNo];
    }
}

- (IBAction)OnDaiXiaoShang:(id)sender {
    if ( !_btnDiaXiaoShang.isSelected && !bCallingService)
    {
        [_btnZhiYing setSelected:NO];
        [_btnDiaXiaoShang setSelected:YES];
        
        [arrItems removeAllObjects];
        [_tblItems reloadData];
        
        [self callAgentGetDepositList:nCurPageNo];
    }
}

- (IBAction)OnMingXiBiao:(id)sender
{

	MinXiBiaoVC *viewVC = [[UIStoryboard storyboardWithName:@"YuanGong" bundle:nil] instantiateViewControllerWithIdentifier:@"SIDMingXiBiao"];
	
	viewVC.employee_id = _employee_id;

    [self.navigationController pushViewController:viewVC animated:YES];

}
@end

