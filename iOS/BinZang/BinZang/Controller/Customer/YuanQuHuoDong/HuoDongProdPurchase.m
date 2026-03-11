//
//  HuoDongProdPurchase.m
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "HuoDongProdPurchase.h"
#import "DaixiaoshangShouyeVC.h"
#import "MIConfirmViewController.h"

@implementation PayProdTableCell
@end

@interface HuoDongProdPurchase ()<MIConfirmDelegate>

@end


#define CELL_HEIGHT				75
#define CELL_ID					@"cellPayProdItem"
#define CUSTOMER_DEF_ID			-1

@implementation HuoDongProdPurchase

@synthesize mSelProducts;
@synthesize mStrTime;
@synthesize mTotalPrice;
@synthesize mBurySvcInfo;
@synthesize mStrType;
@synthesize mTombId;
@synthesize mCustomerID;
@synthesize mIs_DeputyService;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	borderWidthColor(_vwContainer, 1, [UIColor blackColor]);
	[_lblTime setText:mStrTime];
	[_lblServiceName setText:(mBurySvcInfo != nil) ? mBurySvcInfo.title : @""];
	[_lblServicePrice setText:(mBurySvcInfo != nil) ? mBurySvcInfo.price_desc : @""];
	[_lblType setText:mStrType];
	
	[_tblItems reloadData];
	
	// calc total price
	double totalPrice = mTotalPrice;
	totalPrice += (mBurySvcInfo != nil) ? mBurySvcInfo.price : 0;
	[_lblTotalPrice setText:[NSString stringWithFormat:@"%@%.2f", YUANSYMBOL, totalPrice]];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get qingren list service
 */
- (void) callGetItemlist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetActivities];
}

- (void) getActivitiesResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:retmsg afterDelay:DEF_DELAY];
		
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

/**
 * call reserve service
 */
- (void) callReserve
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	long service_id = (mBurySvcInfo == nil) ? -1 : mBurySvcInfo.uid;
	// make products param
	NSMutableArray * prodJson = [[NSMutableArray alloc] init];
	for (int i = 0; i < mSelProducts.count; i++) {
		NSDictionary * prodDic = [mSelProducts objectAtIndex:i];
		NSInteger prodCount = [[prodDic objectForKey:PRODUCT_COUNT] integerValue];
		STProduct * datainfo = (STProduct *)[prodDic objectForKey:PRODUCT_INFO];
		
		NSDictionary * jsonDic = @{
								   @"uid" : [NSString stringWithFormat:@"%ld", (long)datainfo.uid],
								   @"count" : [NSString stringWithFormat:@"%ld", (long)prodCount],
								   };
		
		[prodJson addObject:jsonDic];
	}
	
	NSData *prodInfoData = [NSJSONSerialization dataWithJSONObject:prodJson options:0 error:nil];
	NSString *prodInfoStr = [[NSString alloc] initWithBytes:[prodInfoData bytes] length:[prodInfoData length] encoding:NSUTF8StringEncoding];
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ReserveCerermony:mCustomerID reserve_time:mStrTime tomb_id:mTombId is_deputyservice:mIs_DeputyService bury_service_id:service_id products:prodInfoStr];
}

- (void) reserveCeremonyResult:(NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:retmsg afterDelay:DEF_DELAY];
		
		[self onConfirmOK];
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
	if (mSelProducts == nil) {
		return 0;
	}
	
	return mSelProducts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	PayProdTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	NSDictionary * prodDic = [mSelProducts objectAtIndex:indexPath.row];
	NSInteger prodCount = [[prodDic objectForKey:PRODUCT_COUNT] integerValue];
	STProduct * datainfo = (STProduct *)[prodDic objectForKey:PRODUCT_INFO];
	
	borderWidthColor(cell.vwContainer, 1, [UIColor blackColor]);
	[cell.lblProdType setText:datainfo.type_desc];
	[cell.lblProdName setText:datainfo.title];
	[cell.lblProdCount setText:[NSString stringWithFormat:@"数量：%ld", (long)prodCount]];
	[cell.lblProdPrice setText:datainfo.price_desc];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
	borderWidthColor(cell.imgMain, 1, [UIColor grayColor]);
	
	return cell;
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction

- (IBAction)onTapConfirm:(id)sender
{
	[self callReserve];
}
- (IBAction)onTapBack:(id)sender
{
	[self.view endEditing:YES];
	
	MIConfirmViewController *confVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MIConfirmViewController"];
	
	confVC.delegate = self;
	
	[self addChildViewController:confVC];
	[self.view addSubview:confVC.view];
	[confVC didMoveToParentViewController:self];
}

- (void) onConfirmOK
{
	UIViewController *viewCtrlr;
	long count = [self.navigationController.viewControllers count];
	
	for (long index = count - 1; index >= 0 ; index--)
	{
		viewCtrlr = [self.navigationController.viewControllers objectAtIndex:index];
		
		if ([viewCtrlr isKindOfClass:[MainSwipeViewController class]])
		{
			break;
		}
	}
	if (viewCtrlr)
	{
		[self.navigationController popToViewController:viewCtrlr animated:YES];
	}else{
		[self onTapBack:nil];
	}
}

- (void) onConfirmCancel
{
	[self willMoveToParentViewController:nil];
	
}

@end
