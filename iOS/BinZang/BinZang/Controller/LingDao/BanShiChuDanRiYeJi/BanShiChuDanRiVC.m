//
//  BanShiChuDanRiVC.m
//  BinZang
//
//  Created by KimOkChol on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BanShiChuDanRiVC.h"
#import "MIListView.h"

#pragma mark - BanShiChuDanRiVC

@interface BanShiChuDanRiVC ()<MIListViewDataSource, MIListViewDelegate>
{
	BOOL				isZhuRen;
	NSMutableArray *	arrItems;
	
	STEmployeeDailyScore *sum;
}
@property (weak, nonatomic) IBOutlet MIListView *vwContent;

@end

@implementation BanShiChuDanRiVC

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

#pragma mark - Basic Function

- (void) initControls
{
	isZhuRen = [Common userInfo].user_type == UserType_ZhuRen;

	_vwContent.dataSource = self;
	_vwContent.delegate = self;
	
	[self callGetData];
}

- (void) updateData : (NSMutableArray*)datalist
{
	arrItems = datalist;
	if (isZhuRen)
	{
		sum = [[STEmployeeDailyScore alloc] init];
		sum.name = @"总合计";
		sum.agent = @"";
		sum.price = 0;
		sum.actual = 0;
	}
	[_vwContent reloadData];

}
#pragma mark - Web Service Relation

- (void) callGetData
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	if (isZhuRen)
		[self callGetEmployeesDailyScore];
	else
		[self callGetOfficesDailyScore];
}

/**
 * call get bill list service
 */
- (void) callGetOfficesDailyScore
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficesDailyScore : 0];
}

- (void) GetOfficesDailyScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self updateData:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) callGetEmployeesDailyScore
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetEmployeesDailyScore:[Common userInfo].office_id];
}

- (void) GetEmployeesDailyScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self updateData:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - MIListView datasource, delegate

- (NSInteger) listView:(MIListView *)listView numberOfRowAtSection:(NSInteger)section
{
	if (isZhuRen)
		return [arrItems count] + 2;// header + sum
	else
		return [arrItems count] + 1; //header
}

//for cell
- (NSInteger) numberOfColumn:(MIListView *)listView
{
	return 4;
}

- (CGFloat) rowHeight:(MIListView *)listView
{
	return 50;
}

- (CGFloat) rowWidth:(MIListView *)listView
{
	return _vwContent.frame.size.width;
}

- (NSArray *) columnWidths:(MIListView *)listView
{
	int nWidth = _vwContent.frame.size.width / 4;
	return @[
			 [NSNumber numberWithInt:nWidth],
			 [NSNumber numberWithInt:nWidth],
			 [NSNumber numberWithInt:nWidth],
			 [NSNumber numberWithInt:nWidth],
		];
}

- (NSArray *) listView:(MIListView *)listView textsAtIndexPath:(NSIndexPath*)indexPath
{
	NSInteger row = indexPath.row;
	if (isZhuRen)
	{
		if (row == 0)
		{
			return @[@"名称", @"代销商", @"员工", @"成交价"];
		}
		else if (row == arrItems.count + 1)
		{
			return [sum makeStringArray];
		}
		else
		{
			STEmployeeDailyScore *score = [arrItems objectAtIndex:row - 1];
			
//			sum.agent += score.agent;
			sum.price += score.price;
			sum.actual += score.actual;
			
			return [score makeStringArray];
		}
	}else{
		if (row == 0)
		{
			return @[@"名称", @"自营业绩", @"代销业绩", @"合计"];
		}
		else
		{
			STOfficeDailyScore *score = [arrItems objectAtIndex:row - 1];
			
			return [score makeStringArray];
		}
	}
}

@end
