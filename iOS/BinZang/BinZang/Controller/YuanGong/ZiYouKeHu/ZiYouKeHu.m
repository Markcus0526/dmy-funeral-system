//
//  ZiYouKeHuCX.m
//  BinZang
//
//  Created by Beids on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZiYouKeHu.h"
#import "MJRefresh.h"
#import "ZiYouKeHuDetailVC.h"

#define CELL_ID						@"cell"
#define CELL_HEIGHT					70

#define SEGUE_TO_ZIYOUDETAIL				@"segueToZiYouKeHuDetail"

@interface ZiYouKeHuCell ()
@property (weak, nonatomic) IBOutlet UIView *vwFrame;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblReserveTime;
@property (weak, nonatomic) IBOutlet UILabel *lblReadCheck;

-(void) setDepositLog:(STBuyProductLog*)log;
@end

@implementation ZiYouKeHuCell



-(void) setDepositLog:(STBuyProductLog*)log
{
    
    borderWidthColor(_vwFrame, 1, [UIColor darkGrayColor]);
    _lblName.text = log.customer;
    _lblReserveTime.text = log.reserve_date;
    
    if ( log.is_read )
        _lblReadCheck.hidden = true;
    else
    {
        _lblReadCheck.hidden = false;
        roundRect(_lblReadCheck, _lblReadCheck.frame.size.width / 2);
    }
}

@end

@interface ZiYouKeHuVC ()
{
    NSMutableArray *			arrItems;
    int							nCurPageNo;
    long                        logId;
	BOOL                       bCallingService;
	
	MIListEmptyView		*listEmptyView;
}
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet UIButton *btnZhiYing;
@property (weak, nonatomic) IBOutlet UIButton *btnDiaXiaoShang;

@end

@implementation ZiYouKeHuVC

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
    
    // show HUB first time
    
	[self callGetBuyProductLogs:0 page_number:nCurPageNo];
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
	
	[self callGetBuyProductLogs:_btnZhiYing.selected?0:1 page_number:nCurPageNo];
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


- (bool) inDataList:(STBuyProductLog *)object orglen:(long)orglen
{
    STBuyProductLog *task;
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
    STBuyProductLog *new;
    
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
- (void) callGetBuyProductLogs : (int)state page_number:(int)page_number
{
    bCallingService = true;
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetBuyProductLogs:state page_no:page_number];
}
/*
- (void) callAgentGetDepositList : (int)pageno
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetAgentDepositLogs:[[Common strUserId] integerValue] page_no:pageno];
}*/

- (void) getBuyProductLogsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
    ZiYouKeHuCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STBuyProductLog * datainfo = (STBuyProductLog *)[arrItems objectAtIndex:indexPath.row];
    
    [cell setDepositLog:datainfo];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SEGUE_TO_ZIYOUDETAIL])
    {
        // get current office data
                // set data
        ZiYouKeHuDetailVC * destCtrl = (ZiYouKeHuDetailVC *)segue.destinationViewController;
        destCtrl.log_id = logId;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STBuyProductLog * datainfo = (STBuyProductLog *)[arrItems objectAtIndex:indexPath.row];
    
    logId = datainfo.uid;
    
    [self performSegueWithIdentifier:SEGUE_TO_ZIYOUDETAIL sender:nil];
}

- (IBAction)OnZhiYing:(id)sender {
    if ( !_btnZhiYing.isSelected && !bCallingService)
    {
        [_btnZhiYing setSelected:YES];
        [_btnDiaXiaoShang setSelected:NO];
        
        [arrItems removeAllObjects];
        [_tblItems reloadData];
		nCurPageNo = 0;
        
        [self callGetBuyProductLogs:0 page_number:nCurPageNo];
    }
}

- (IBAction)OnDaiXiaoShang:(id)sender {
    if ( _btnZhiYing.isSelected && !bCallingService )
    {
        [_btnZhiYing setSelected:NO];
        [_btnDiaXiaoShang setSelected:YES];
        
        [arrItems removeAllObjects];
        [_tblItems reloadData];
		nCurPageNo = 0;
		
        [self callGetBuyProductLogs:1 page_number:nCurPageNo];
    }
}


@end

