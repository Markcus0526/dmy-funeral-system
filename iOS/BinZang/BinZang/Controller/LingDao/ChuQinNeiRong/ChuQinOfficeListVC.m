//
//  ChuQinOfficeListVC.m
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ChuQinOfficeListVC.h"
#import "MIListView.h"

@interface ChuQinOfficeListVC ()<MIListViewDataSource, MIListViewDelegate>
{
	long office_id;
	
	NSMutableArray *vocations;
}

@property (weak, nonatomic) IBOutlet MIListView *vwListView;

@end

@implementation ChuQinOfficeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setVocations:(NSMutableArray *)voca
{
	vocations = voca;
	[_vwListView reloadData];
}

- (void) initControls
{
	_vwListView.dataSource = self;
	_vwListView.delegate = self;
}
 
- (void) setOfficeID : (long)officeID
{
	office_id = officeID;
	[self callGetData];
}

#pragma mark - Web Service Relation

- (void) callGetData
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	[self callGetOfficesAttendanceList];
}

/**
 * call get bill list service
 */
- (void) callGetOfficesAttendanceList
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficesAttendanceList:office_id];
}

- (void) GetOfficesAttendanceListResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self setVocations:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


#pragma mark - MIListView datasource, delegate

- (NSInteger) listView:(MIListView *)listView numberOfRowAtSection:(NSInteger)section
{
	return [vocations count] + 1;
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
	return listView.frame.size.width;
}

- (NSArray *) columnWidths:(MIListView *)listView
{
	CGRect frame = listView.frame;
	
	int per = frame.size.width / 6;
	
	return @[
		[NSNumber numberWithInt:per * 2],
		[NSNumber numberWithInt:per * 2],
		[NSNumber numberWithInt:per],
		[NSNumber numberWithInt:per],
	];
}

- (NSArray *) listView:(MIListView *)listView textsAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = indexPath.row;
	if (row == 0)
	{
		return @[@"名称", @"职位", @"当月", @"年度"];
	}
	else
	{
		STVocation *voc = [vocations objectAtIndex:row - 1];
		
		return [voc makeStringArray];
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
