//
//  MinXiBiaoVC.m
//  BinZang
//
//  Created by KimOkChol on 4/29/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MinXiBiaoVC.h"
#import "MJRefresh.h"

#define CELL_ID						@"celll"
#define CELL_HEIGHT					110

@interface MingXiBiaoCell()

-(void) setDepositLog:(STBonusDetailInfo*)log;
@end


@implementation MingXiBiaoCell

-(void) setDepositLog:(STBonusDetailInfo*)log
{
    borderWidthColor(_vwFrame, 1, [UIColor darkGrayColor]);
    _lblDealTime.text = log.buy_time;
    _lblName.text = log.user_name;
    _lblTombID.text = log.tomb_no;
    _lblPrice.text = log.bonus_desc;
}

@end

@interface MinXiBiaoVC ()
{
    NSMutableArray *			arrItems;
    int							nCurPageNo;

	NSMutableArray *			arrQiTaItems;
	NSMutableArray *			arrJiPinItems;
	
	
	MIListEmptyView		*listEmptyView;
}
@property (weak, nonatomic) IBOutlet UIButton *btnQita;
@property (weak, nonatomic) IBOutlet UIButton *btnJiPin;

@end



@implementation MinXiBiaoVC

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
	[_tblItemss layoutIfNeeded];
	if (!listEmptyView)
	{
		listEmptyView = [[MIListEmptyView alloc] initWithFrame:_tblItemss.frame];
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
	
	_btnQita.selected = YES;
	_btnJiPin.selected = NO;
	
    // setup pull to refresh
    [self setupTableRefresh];
    
	[self callGetBonusList:NO pageno:nCurPageNo];
}


#pragma mark - Pull refresh event

- (void)setupTableRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tblItemss addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tblItemss.footerPullToRefreshText = MSG_TBLFOOTER_PULL;
    _tblItemss.footerReleaseToRefreshText = MSG_TBLFOOTER_RELEASE;
    _tblItemss.footerRefreshingText = MSG_TBLFOOTER_REFRESHING;
}

- (void)footerRereshing
{
    nCurPageNo = (int)[arrItems count] / PAGE_COUNT;
	
	[self callGetBonusList:_btnJiPin.selected pageno:nCurPageNo];
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
			if (_btnQita.selected)
			{
				arrQiTaItems = newItems;
				arrItems = arrQiTaItems;
			}
			else
			{
				arrJiPinItems = newItems;
				arrItems = arrJiPinItems;
			}
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
	
    [_tblItemss reloadData];
    
    // stop refreshing
    [_tblItemss footerEndRefreshing];
}

- (bool) inDataList:(STBonusDetailInfo *)object orglen:(long)orglen
{
    STBonusDetailInfo *task;
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
    STBonusDetailInfo *new;
    
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
- (void) callGetBonusList : (bool) bonus_type pageno:(int)pageno
{
    TEST_NETWORK_RETURN;
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetBonusDetailList:_employee_id bonus_type:bonus_type page_no:pageno];
}

- (void) getBonusDetailListResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
    MingXiBiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STBonusDetailInfo * datainfo = (STBonusDetailInfo *)[arrItems objectAtIndex:indexPath.row];
    
    [cell setDepositLog:datainfo];
    
    return cell;
}

- (IBAction)onTapQiTa:(id)sender
{
	_btnQita.selected = YES;
	_btnJiPin.selected = NO;
	
	arrItems = arrQiTaItems;
	if (!arrItems || arrItems.count <= 0)
	{
		listEmptyView.hidden = NO;
	}else
		listEmptyView.hidden = YES;
	if (!arrQiTaItems)
	{
		nCurPageNo = 0;
		[self callGetBonusList:NO pageno:nCurPageNo];
	}else
	{
		nCurPageNo = (int)arrQiTaItems.count / PAGE_COUNT;
		[_tblItemss reloadData];
	}
}

- (IBAction)onTapJiPin:(id)sender
{
	_btnQita.selected = NO;
	_btnJiPin.selected = YES;
	
	arrItems = arrJiPinItems;
	if (!arrItems || arrItems.count <= 0)
	{
		listEmptyView.hidden = NO;
	}else
		listEmptyView.hidden = YES;
	if (!arrJiPinItems)
	{
		nCurPageNo = 0;
		[self callGetBonusList:YES pageno:nCurPageNo];
	}
	else{
		nCurPageNo = (int)arrJiPinItems.count / PAGE_COUNT;
		[_tblItemss reloadData];
	}
}

@end
