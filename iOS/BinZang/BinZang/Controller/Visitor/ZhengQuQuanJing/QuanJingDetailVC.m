//
//  QuanJingDetailVC.m
//  BinZang
//
//  Created by Admin on 20/04/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "QuanJingDetailVC.h"

#define SEGUE_TO_DETAIL                     @"segueFromQuanJingToDetail"
#define CELL_ID                             @"QuanJingDetailCell"
#define CELL_HEIGHT					90

@implementation QuanJingDetailCell
@end

@implementation QuanJingDetailVC
@synthesize nUidOfQuanJing;
@synthesize mDetailInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyLog(@"QuanJingDetailVC %d", nUidOfQuanJing);
    
    [self callGetAreaPointDetail];
    
    _mTitleLabel.text = @"";
    _mContentTextView.text = @"";
    _mSubTitleLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*if ([SEGUE_TO_DETAIL compare: segue.identifier]==NSOrderedSame) {
        int nUid = (int)sender;
        MyLog(@"Prepare --- %d", nUid);
    }*/
}

- (void) callGetAreaPointDetail
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetAreaPointDetail:nUidOfQuanJing];
}

- (void) getAreaPointDetail:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STAreaPointDetail *)datainfo
{
    if (retcode == SVCERR_SUCCESS)
    {
        [SVProgressHUD dismiss];
        
        mDetailInfo = datainfo;
        [self updateUI];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}

- (void) updateUI
{
    if ( mDetailInfo != nil )
    {
        _mTitleLabel.text = mDetailInfo.name;
        _mContentTextView.text = mDetailInfo.contents;
        _mSubTitleLabel.text = @"园区介绍";
    }
    [_tblView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (mDetailInfo == nil || mDetailInfo.products == nil ) {
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
    QuanJingDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    if (cell == nil)
    {
        cell = [[QuanJingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
    }
    
    
    STAreaPointDetailMembers * datainfo = (STAreaPointDetailMembers *)[mDetailInfo.products objectAtIndex:indexPath.row];
    //[cell.lblTitle setText:datainfo.title];
    [cell.mImageView setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
    borderWidthColor(cell.mImageView, 1, [UIColor grayColor]);
    //[cell.btnMain setTag:indexPath.row];
    cell.mYouLaiText.text = datainfo.title;
    cell.mPriceDescLabel.text = datainfo.price_desc;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
