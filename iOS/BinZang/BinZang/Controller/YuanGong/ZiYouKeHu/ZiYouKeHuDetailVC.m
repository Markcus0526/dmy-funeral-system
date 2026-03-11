//
//  ZiYouKeHuDetailVC.m
//  BinZang
//
//  Created by Beids on 5/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZiYouKeHuDetailVC.h"
#import "MJRefresh.h"

#define SEGUE_TO_DETAIL                     @"segueFromQuanJingToDetail"
#define CELL_ID                             @"ZiYouKeHuDetailCell"
#define CELL_HEIGHT					25

@interface ZiYouKeHuDetailTblCell()
-(void) SetCellInfos:(STBuyProductContent*)log;
@end

@implementation ZiYouKeHuDetailTblCell
-(void) SetCellInfos:(STBuyProductContent*)log
{
    _lblContent.text =  [NSString stringWithFormat:@"%@ (%@)", log.title, log.amount_desc];
    _lblPrice.text = log.price_desc;
}
@end

@interface ZiYouKeHuDetailVC ()
{
   
}
@end

@implementation ZiYouKeHuDetailVC
@synthesize mDetailInfo;
@synthesize log_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControls];
    [self callGetBuyProductLogDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initControls
{    
    _lblCustomer.text = @"";
    _lblPhone.text = @"";
    
    _lblAgent.text =  @"";

    _lbl_reserver_date.text = @"";
    _lbl_service_type.text = @"";
    
    //borderWidthColor(_v1, 1, [UIColor redColor]);
    //borderWidthColor(_scv, 1, [UIColor blueColor]);
    //borderWidthColor(_cv, 1, [UIColor greenColor]);
}

- (void)UpdateInfos
{
    _lblCustomer.text = mDetailInfo.customer;
    _lblPhone.text = mDetailInfo.phone;
    
    _lblAgent.text = mDetailInfo.agent;
    _lbl_reserver_date.text = mDetailInfo.reserve_date;
    _lbl_service_type.text = mDetailInfo.service_type;
    
    _lblState.text = mDetailInfo.state_desc;
    
    [_tblItems reloadData];
    
    // stop refreshing
    [_tblItems footerEndRefreshing];
    
    if ( mDetailInfo.is_read == 1 )
        [self callReadBuyProductLog];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) callGetBuyProductLogDetails 
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetBuyProductLogDetails:log_id];
}

- (void) getBuyProductLogDetailsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STBuyProductLogDetail *)datainfo
{
    if (retcode == SVCERR_SUCCESS)
    {
        [SVProgressHUD dismiss];
        
        mDetailInfo = datainfo;
        
        if ( mDetailInfo.products.count > 1 )
        _constraintBuyInfoHeight.constant = mDetailInfo.products.count * CELL_HEIGHT;
        
        _constraintContentViewHeight.constant += (mDetailInfo.products.count - 1) * CELL_HEIGHT;
        [self UpdateInfos];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}

- (void) callReadBuyProductLog
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] ReadBuyProductLog:log_id];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (mDetailInfo == nil) {
        return 0;
    }
    
    return mDetailInfo.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* szID = CELL_ID;
    ZiYouKeHuDetailTblCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    STBuyProductContent * datainfo = (STBuyProductContent *)[mDetailInfo.products objectAtIndex:indexPath.row];
    
    [cell SetCellInfos:datainfo];
    
    return cell;
}
@end
