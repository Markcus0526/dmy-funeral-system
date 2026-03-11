//
//  GeRenYeJiVC.m
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "GeRenYeJiVC.h"
#import "MIListView.h"

@interface GeRenYeJiVC ()<MIListViewDataSource, MIListViewDelegate>
{
	NSMutableArray *arrItems;
}

@property (weak, nonatomic) IBOutlet MIListView *vwListView;

@end

@implementation GeRenYeJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initControls
{
	_vwListView.dataSource = self;
	_vwListView.delegate = self;
	[self callGetData];
}

#pragma mark - Web Service Relation

- (void) callGetData
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	[self callGetEmployeePersonalScoreMgr];
}

/**
 * call get bill list service
 */
- (void) callGetEmployeePersonalScoreMgr
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetEmployeePersonalScoreMgr];
}

- (void) GetEmployeePersonalScoreMgrResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		arrItems = datalist;
		[_vwListView reloadData];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - MIListView datasource, delegate

- (NSInteger) numberOfSection:(MIListView *)listView
{
	return [arrItems count] + 1;
}

- (NSInteger) listView:(MIListView *)listView numberOfRowAtSection:(NSInteger)section
{
	if (section == 0)//for title
		return 1;
	
	STEmpScore_Manager *emp = [arrItems objectAtIndex:section - 1];
	
	return [emp.scores count] + 1;
}

//for cell
- (NSInteger) numberOfColumn:(MIListView *)listView
{
	return 8;
}

- (CGFloat) rowHeight:(MIListView *)listView
{
	return 50;
}

- (CGFloat) rowWidth:(MIListView *)listView
{
	return 800;
}

- (NSArray *) columnWidths:(MIListView *)listView
{
	return @[
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
		[NSNumber numberWithInt:100],
	];
}

- (NSArray *) listView:(MIListView *)listView textsAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger section = indexPath.section;
	if (section == 0)
	{
		return @[@"员工名称", @"区分", @"代销商本月\n业绩累计", @"员工本月\n业绩累计", @"自营比例", @"责任额", @"本月总业绩", @"达成比例"];
	}
	else
	{
		STEmpScore_Manager *emp = [arrItems objectAtIndex:section - 1];
		NSInteger row = indexPath.row;
		
		NSMutableArray *values;
		if (row < emp.scores.count)
		{
			
			STScore_Manager *score = [emp.scores objectAtIndex:row];
		
			values = [[score makeStringArray] mutableCopy];
		
			NSString *strName;
			if (row == 0)
				strName = emp.user_name;
			else
				strName = @"";
		
			[values insertObject:strName atIndex:0];
		
			return values;
		}else{
			
			return [emp makeStringArray];
		}
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

@end
