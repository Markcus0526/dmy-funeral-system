//
//  BanShiChuDanYueVC.m
//  BinZang
//
//  Created by KimOkChol on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BanShiChuDanYueVC.h"
#import "MIListView.h"

@interface TableCell()
@property (weak, nonatomic) IBOutlet UILabel *Title;
@end

@implementation TableCell

-(void) setValue : (NSString*)value
{
	self.Title.text = value;
}
@end

@interface BanShiChuDanYueVC ()<MIListViewDelegate, MIListViewDataSource>
{
	long				curMonth;
	BOOL				isZhuRen;
	STOfficeMonthlyScore*	sum;
	
	NSMutableArray *	arrItems;
}

@property (weak, nonatomic) IBOutlet MIListView *vwContent;
@property (weak, nonatomic) IBOutlet UIView *vwSelector;
@property (weak, nonatomic) IBOutlet UILabel *lblSelector;
@property (weak, nonatomic) IBOutlet UIView *vwTopBar;

@property (weak, nonatomic) IBOutlet UIView *vwSelectorView;
@property (strong, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSelectHeight;
@end

@implementation BanShiChuDanYueVC

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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	_vwSelectorView.hidden = YES;
}

- (void) initControls
{
	isZhuRen = [Common userInfo].user_type == UserType_ZhuRen;
	
	if (isZhuRen)
	{
		_vwTopBar.hidden = YES;
		_constraintSelectHeight.constant = 0;
	}
	curMonth = [[NSCalendar currentCalendar] component:NSMonthCalendarUnit fromDate:[NSDate date]];
	_lblSelector.text = [NSString stringWithFormat:@"%ld月", curMonth];
	
	roundRect(_vwSelector, DEF_CORNER_RADIO);
	borderWidthColor(_vwSelector, 0.5, [UIColor darkGrayColor]);
	_vwSelectorView.hidden = YES;
	
	_vwContent.delegate = self;
	_vwContent.dataSource = self;
	
	[self callGetData];
}

- (void) updateData : (NSMutableArray*)datalist
{
	arrItems = datalist;
	if (isZhuRen)
	{
		sum = [[STOfficeMonthlyScore alloc] init];
		
		sum.order = @"总合计";
		sum.agent = 0;
		sum.employee = 0;
		sum.total = 0;
		sum.response_value = 0;
		sum.office_income = 0;
	}
	[_vwContent reloadData];
	
}

- (IBAction)onTapSelector:(id)sender
{
	_vwSelectorView.hidden = NO;
}

#pragma mark - Web Service Relation

- (void) callGetData
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];

	if (isZhuRen)
		[self callGetOfficeMonthlyScore];
	else
		[self callGetOfficesCurMonthScore];
}

/**
 * call get bill list service
 */
- (void) callGetOfficesCurMonthScore
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficesCurMonthScore:curMonth];
}

- (void) GetOfficesCurMonthScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (void) callGetOfficeMonthlyScore
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficeMonthlyScore:[Common userInfo].office_id];
}

- (void) GetOfficeMonthlyScoreResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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
		return [arrItems count] + 2;
	else
		return [arrItems count] + 1;
}

//for cell
- (NSInteger) numberOfColumn:(MIListView *)listView
{
	if (isZhuRen)
		return 8;
	else
		return 8;
}

- (CGFloat) rowHeight:(MIListView *)listView
{
	return 50;
}

- (CGFloat) rowWidth:(MIListView *)listView
{
	if (isZhuRen)
		return 840;
	else
		return 1000;
}

- (NSArray *) columnWidths:(MIListView *)listView
{
	if (isZhuRen)
		return @[
			 [NSNumber numberWithInt:80],
			 [NSNumber numberWithInt:140],
			 [NSNumber numberWithInt:120],
			 [NSNumber numberWithInt:100],
			 [NSNumber numberWithInt:80],
			 [NSNumber numberWithInt:80],
			 [NSNumber numberWithInt:100],
			 [NSNumber numberWithInt:140]
			 ];
	else
		return @[
				 [NSNumber numberWithInt:160],
				 [NSNumber numberWithInt:140],
				 [NSNumber numberWithInt:120],
				 [NSNumber numberWithInt:100],
				 [NSNumber numberWithInt:80],
				 [NSNumber numberWithInt:80],
				 [NSNumber numberWithInt:100],
				 [NSNumber numberWithInt:140]
				 ];
}

- (NSArray *) listView:(MIListView *)listView textsAtIndexPath:(NSIndexPath*)indexPath
{
	NSInteger row = indexPath.row;
	if (isZhuRen)
	{
		if (row == 0)
		{
			return @[@"区分", @"代销商业绩累计", @"员工业绩累计", @"自营比率", @"责任额", @"总业绩", @"达成比率", @"办事处营余累计"];
		}
		else if (row == arrItems.count + 1)
		{
			sum.self_rate = sum.employee * 100 / (sum.employee + sum.agent);
			sum.success_rate = (sum.agent + sum.employee) * 100 / sum.response_value;
			
			return [sum makeStringArray];
		}
		else
		{
			STOfficeMonthlyScore *score = [arrItems objectAtIndex:row - 1];
			
			sum.agent += score.agent;
			sum.employee += score.employee;
			sum.response_value += score.response_value;
			sum.total += score.total;
			sum.office_income += score.office_income;
			
			return [score makeStringArray];
		}
	}else{
		if (row == 0)
		{
			return @[@"办事处", @"代销商业绩累计", @"员工业绩累计", @"自营比率", @"责任额", @"总业绩", @"达成比率", @"办事处营余累计"];
		}
		else
		{
			STOfficeCurMonthScore *score = [arrItems objectAtIndex:row - 1];
			
			return [score makeStringArray];
		}
	}
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 12;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
	return _header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = @"cell";
	TableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	[cell setValue:[NSString stringWithFormat:@"%ld月", (long)indexPath.row + 1]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_vwSelectorView.hidden = YES;
	
	curMonth = indexPath.row + 1;
	_lblSelector.text = [NSString stringWithFormat:@"%ld月", curMonth];
	
	[self callGetData];
}

@end
