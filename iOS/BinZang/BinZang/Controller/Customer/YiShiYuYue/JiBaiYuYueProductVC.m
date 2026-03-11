//
//  JiBaiYuYueVC.m
//  BinZang
//
//  Created by KimOkChol on 4/25/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "JiBaiYuYueProductVC.h"
#import "HuoDongProdPurchase.h"
#import "HuoDongProdTableViewCell.h"
#import "DaixiaoshangShouyeVC.h"
#import "MIConfirmViewController.h"

@interface JiBaiYuYueProductVC ()<MIConfirmDelegate>
{
	NSMutableArray *			arrItems;
	NSMutableArray *			arrAllItems;
	
	enum EN_PROD_TYPE 			enCurType;
	
	NSMutableArray *			arrSelProducts;
	double 						nTotalPrice;
}
@property (weak, nonatomic) IBOutlet UIView *vwTabBar;
@property (weak, nonatomic) IBOutlet UIView *vwShangPin2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainShangPin2Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintShangPin2Equal;

@property (weak, nonatomic) IBOutlet UIButton *chkType1;
@property (weak, nonatomic) IBOutlet UIButton *chkType2;
@property (weak, nonatomic) IBOutlet UIButton *chkType3;
@property (weak, nonatomic) IBOutlet UIButton *chkType4;
@property (weak, nonatomic) IBOutlet UIButton *btnPrevious;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@end


#define CELL_ID						@"cellActProduct"
#define CELL_HEIGHT					83

@implementation JiBaiYuYueProductVC

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
	enCurType = PROD_TYPE1;
	roundRect(_btnNext, DEF_CORNER_RADIO);
	roundRect(_btnPrevious, DEF_CORNER_RADIO);
	borderWidthColor(_btnPrevious, 0.5, [UIColor darkGrayColor]);
	
	NSString *strType = [_tokenData objectForKey:@"StrType"];
	if ([strType isEqualToString:STR_JIBAI])
	{
		[_vwTabBar removeConstraint:_constraintShangPin2Equal];
		
		_constrainShangPin2Width.constant = 0;
		_vwShangPin2.hidden = YES;
		
		[_vwTabBar layoutMarginsDidChange];
		[_vwTabBar layoutIfNeeded];

	}
	
	[self callGetItemlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
	arrAllItems = newItems;
	arrItems = [self getItemsByType:enCurType];
	
	[_tblItems reloadData];
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
	[[[CommManager getCommMgr] comSvcMgr] GetFuneralProducts];
}

- (void) getFuneralProdResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
	HuoDongProdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STProduct * datainfo = (STProduct *)[arrItems objectAtIndex:indexPath.row];
	[cell setData:datainfo];
	
	return cell;
}

/**
 * go to purchase view controller
 */
- (void) gotoPurchase
{
	// go to purchase view
	HuoDongProdPurchase * purchaseVC = (HuoDongProdPurchase *)[self.storyboard instantiateViewControllerWithIdentifier:VC_ID_PURCHASE];
	
//	bool isAgent = [[_tokenData objectForKey:@""] boolValue];
	purchaseVC.mCustomerID = [Common userInfo].uid;
	purchaseVC.mIs_DeputyService = [_tokenData objectForKey:@"DaiJiBai"]?1:0;
	purchaseVC.mSelProducts = arrSelProducts;
	purchaseVC.mStrTime = [_tokenData objectForKey:@"ReserveDate"];
	purchaseVC.mTotalPrice = nTotalPrice;
	purchaseVC.mBurySvcInfo = [_tokenData objectForKey:@"BuryInfo"];
	purchaseVC.mStrType = [_tokenData objectForKey:@"StrType"];
	purchaseVC.mTombId = [[_tokenData objectForKey:@"TombID"] longValue];
	
	[self.navigationController pushViewController:purchaseVC animated:YES];
}

- (NSMutableArray *) getItemsByType : (enum EN_PROD_TYPE)type
{
	NSMutableArray * items = [[NSMutableArray alloc] init];
	for (STProduct * one in arrAllItems) {
		if (one.type == type) {
			[items addObject:one];
		}
	}
	
	return items;
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - UIAlertView Delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1)
	{
		[self gotoPurchase];
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction

- (IBAction)onTapType1:(id)sender
{
	enCurType = PROD_TYPE1;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:YES];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType2:(id)sender
{
	enCurType = PROD_TYPE2;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:YES];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType3:(id)sender
{
	enCurType = PROD_TYPE3;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:YES];
	[_chkType4 setSelected:NO];
	
	[_tblItems reloadData];
}

- (IBAction)onTapType4:(id)sender
{
	enCurType = PROD_TYPE4;
	arrItems = [self getItemsByType:enCurType];
	
	[_chkType1 setSelected:NO];
	[_chkType2 setSelected:NO];
	[_chkType3 setSelected:NO];
	[_chkType4 setSelected:YES];
	
	[_tblItems reloadData];
}

- (IBAction)onTapNext:(id)sender
{
	NSMutableArray * selArray = [[NSMutableArray alloc] init];
	
	// check selected amount
	nTotalPrice = 0;

	for (STProduct *product in arrAllItems)
	{
		NSInteger count = product.req_count;
		if (count > 0)
		{
			NSDictionary *prodDic = @{
									  PRODUCT_INFO : product,
									  PRODUCT_COUNT : [NSNumber numberWithInteger:count]
									  };
			
			nTotalPrice += product.price * count;
			// add selected product
			[selArray addObject:prodDic];
		}
	}

	// save selected products;
	arrSelProducts = selArray;
	
	// check selected count
	STBuryService *buryService = [_tokenData objectForKey:@"BuryInfo"];
	if ([selArray count] == 0 && !buryService)
	{
		bool needBuryService = [[_tokenData objectForKey:@"NeedBuryService"] boolValue];
		UIAlertView * alert;
		if (needBuryService)
			alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_BUY_JIPINPROD delegate:nil cancelButtonTitle:STR_BUTTON_CONFIRM otherButtonTitles:nil, nil];
		else
			alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_BUY_YISHI delegate:nil cancelButtonTitle:STR_BUTTON_CONFIRM otherButtonTitles:nil, nil];
		
		[alert show];
	}
	else if ([selArray count] == 0)
	{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_NONE_JIPINPROD delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
		[alert show];
	}
	else
	{
		[self gotoPurchase];
	}
}

- (IBAction)onTapCancel:(id)sender
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
