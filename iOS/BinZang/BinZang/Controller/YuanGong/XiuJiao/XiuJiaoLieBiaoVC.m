//
//  XiuJiaoLieBiaoVC.m
//  BinZang
//
//  Created by Beids on 5/10/15.
//  Copyright (c) 2015 damy. All rights reserved.
//


#import "XiuJiaoLieBiaoVC.h"
#import "MJRefresh.h"

#define CELL_ID						@"cell"
#define CELL_HEIGHT					60

@interface XiuJiaoQuQiaoCell ()
{
    long uid;
    XiuJiaoLieBiaoVC *parentVC;
}
-(void) setDepositLog:(STYVocation*)log  parentUVC:(XiuJiaoLieBiaoVC*)parentUVC;
@end

@implementation XiuJiaoQuQiaoCell
-(void) setDepositLog:(STYVocation*)vocData parentUVC:(XiuJiaoLieBiaoVC*)parentUVC
{
    borderWidthColor(_vwFrame, 1, [UIColor darkGrayColor]);
    uid = vocData.uid;
    _lblDate.text = vocData.date;
    _lblReason.text = vocData.reason_desc;
    
    parentVC = parentUVC;
}


- (IBAction)OnClickCancelButton:(id)sender {
    //[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    [self callCancelVocation];
}

- (void) callCancelVocation
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] CancelVocation:uid];
}

- (void) cancelVocationResult:(NSInteger)retcode retmsg:(NSString *)retmsg cancelled_id:(long)cancelled_id
{
    if (retcode == SVCERR_SUCCESS)
    {
        //[SVProgressHUD dismiss];
        if ( cancelled_id >= 0 )
        {
            [parentVC initControls];
            //parentVC;
            /*if ( arrItems != nil )
            {
                //[arrItems autorelease];
                arrItems = nil;
            }
            [self callGetVocationDates];*/
        }
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}
@end



@interface XiuJiaoLieBiaoVC ()
{
    NSMutableArray *			arrItems;
	
	MIListEmptyView		*listEmptyView;
}

@end

@implementation XiuJiaoLieBiaoVC

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


-(void) initControls
{
    arrItems = nil;
    [self setupTableRefresh];
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    [self callGetVocationDates];
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

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
    if (arrItems != nil)
    {
        [arrItems removeAllObjects];
    }
    else
        arrItems = [[NSMutableArray alloc] init];
    
    if([newItems count] > 0)
    {
 
        
        for ( int i = 0; i < newItems.count; i++ )
        {
            STYVocation *styData = (STYVocation*)[newItems objectAtIndex:i];
            if ( styData.state == 0 )
                [arrItems addObject:styData];
        }
        //calendar.re
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

- (void)footerRereshing
{
    [self callGetVocationDates];
}

- (bool) inDataList:(STYVocation *)object orglen:(long)orglen
{
    STYVocation *task;
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
    STYVocation *new;
    
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

- (void) callGetVocationDates
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetVocationDates];
}


- (void) getVocationDatesResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    XiuJiaoQuQiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STYVocation * datainfo = (STYVocation *)[arrItems objectAtIndex:indexPath.row];
    
    [cell setDepositLog:datainfo parentUVC:self];
    
    return cell;
}


@end
