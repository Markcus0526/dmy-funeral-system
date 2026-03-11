//
//  DaiXaioRenYuanVC.m
//  BinZang
//
//  Created by KimOkChol on 4/29/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "DaiXaioRenYuanVC.h"
#import "MJRefresh.h"

#define CELL_ID						@"celll"
#define CELL_HEIGHT					120

@interface DaiXaioRenYuanCell()

-(void) setDepositLog:(STAgents*)log;
@end


@implementation DaiXaioRenYuanCell


-(void) setDepositLog:(STAgents*)log
{
    borderWidthColor(_vwFrame, 1, [UIColor darkGrayColor]);
    _lblName.text = log.name;
    _lblPhoneNumber.text = log.phone;
    _lblDangYue.text = log.month_score_desc;
    _lblBanNian.text = log.halfyear_score_desc;
    _lblNianDo.text = log.year_score_desc;
}

@end

@interface DaiXaioRenYuanVC ()
{
    NSMutableArray *			arrItems;
    int							nCurPageNo;
	
	MIListEmptyView		*listEmptyView;
}

@end



@implementation DaiXaioRenYuanVC

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
    
    // setup pull to refresh
    [self setupTableRefresh];
    
    // show HUB first time
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    [self callGetAgents];
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
    [self callGetAgents];
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
    [_tblItemss reloadData];
    
    // stop refreshing
    [_tblItemss footerEndRefreshing];
}

- (bool) inDataList:(STAgents *)object orglen:(long)orglen
{
    STAgents *task;
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
    STAgents *new;
    
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
- (void) callGetAgents
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetAgents];
}

- (void) getAgentsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
    DaiXaioRenYuanCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STAgents * datainfo = (STAgents *)[arrItems objectAtIndex:indexPath.row];
    
    [cell setDepositLog:datainfo];
    
    return cell;
}


@end
