//
//  HuoDongProdListVC.m
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "HuoDongProdListVC.h"
#import "HuoDongProdPurchase.h"
#import "MIActionSheet.h"

@interface HuoDongProdListVC ()
{
	NSMutableArray *			arrItems;
	
	MIActionSheet *      		actionSheet;
	MIDatePickerView *   		datePicker;
	
	NSMutableArray *			arrSelProducts;
	double 						nTotalPrice;
}
@end


#define CELL_ID						@"cellActProduct"
#define CELL_HEIGHT					83

@implementation HuoDongProdListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self initControls];
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	actionSheet = [[MIActionSheet alloc]init];
	actionSheet.delegate = self;
	datePicker = [[MIDatePickerView alloc] init];
	
	[self callGetItemlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
	arrItems = newItems;
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
	[[[CommManager getCommMgr] comSvcMgr] GetActivityProducts];
}

- (void) getActivityProdResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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



///////////////////////////////////////////////////////////////////////////
#pragma mark - Custom Picker Delegate

- (void) okSelector:(long)index value:(NSString *)value
{
	// go to purchase view
	HuoDongProdPurchase * purchaseVC = (HuoDongProdPurchase *)[self.storyboard instantiateViewControllerWithIdentifier:VC_ID_PURCHASE];
	
	purchaseVC.mCustomerID = [Common userInfo].uid;
	purchaseVC.mSelProducts = arrSelProducts;
	purchaseVC.mStrTime = value;
	purchaseVC.mTotalPrice = nTotalPrice;

	[self.navigationController pushViewController:purchaseVC animated:YES];
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


- (IBAction)onTapPurchase:(id)sender
{
	NSMutableArray * selArray = [[NSMutableArray alloc] init];
	
	// check selected amount
	nTotalPrice = 0;
#if 0
	for (int i = 0; i < arrItems.count; i++)
	{
		NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		HuoDongProdTableViewCell * cell = (HuoDongProdTableViewCell *)[_tblItems cellForRowAtIndexPath:indexPath];
		NSInteger count = [cell.txtAmount.text integerValue];
		if (count > 0)
		{
			STProduct * product = [arrItems objectAtIndex:i];
			NSDictionary *prodDic = @{
					  PRODUCT_INFO : product,
					  PRODUCT_COUNT : [NSNumber numberWithInteger:count]
            };
			
			nTotalPrice += product.price * count;
			// add selected product
			[selArray addObject:prodDic];
		}
	}
#else
	for (STProduct *product in arrItems)
	{
		int count = product.req_count;
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
#endif
	
	// check selected count
	if ([selArray count] == 0)
	{
		showToast(MSG_SELECT_PRODUCT);
		return;
	}
	
	// save selected products;
	arrSelProducts = selArray;
	
	[actionSheet setPickerValue:(UIPickerView<CustomPickerView>*)datePicker value:@""];
	[actionSheet showActionSheet];
	
}

@end
