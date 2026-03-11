//
//  ChuQinOfficeVC.m
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ChuQinOfficeVC.h"
#import "ChuQinOfficeCalendarVC.h"
#import "ChuQinOfficeListVC.h"
#import "NSDate+String.h"

@interface ChuQinOfficeVC ()
{
	NSMutableArray *	arrItems;
	
	ChuQinOfficeCalendarVC*	calendarVC;
	ChuQinOfficeListVC*		listVC;
}
@property (weak, nonatomic) IBOutlet UIView *vwCalendar;
@property (weak, nonatomic) IBOutlet UIView *vwList;

@property (weak, nonatomic) IBOutlet UIImageView *imgCalendar;
@property (weak, nonatomic) IBOutlet UIImageView *imgList;

@end

@implementation ChuQinOfficeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Basic Functions

- (void) initControls
{
	[_vwCalendar layoutIfNeeded];
	[_vwList layoutIfNeeded];
	for (UIViewController *child in self.childViewControllers) {
		if ([child isKindOfClass:ChuQinOfficeCalendarVC.class])
		{
			calendarVC = (ChuQinOfficeCalendarVC*)child;
		}
		else if ([child isKindOfClass:ChuQinOfficeListVC.class])
		{
			listVC = (ChuQinOfficeListVC*)child;
		}
	}
	if (_officeName)
	{
		self.navigationItem.title = [NSString stringWithFormat:@"'%@'出勤内容", _officeName];
	}
	
	_imgCalendar.highlighted = YES;
	_imgList.highlighted = NO;
	
	if (_imgCalendar.highlighted == YES)
	{
		_vwCalendar.hidden = NO;
		_vwList.hidden = YES;
	}
	else{
		_vwCalendar.hidden = YES;
		_vwList.hidden = NO;
	}
	
	[self callGetData];
}

- (IBAction)onTapSelectType:(id)sender
{
	if (_imgCalendar.highlighted)
	{
		_imgCalendar.highlighted = NO;
		_imgList.highlighted = YES;
		
		_vwList.hidden = NO;
		_vwCalendar.hidden = YES;
	}else{
		_imgCalendar.highlighted = YES;
		_imgList.highlighted = NO;

		_vwList.hidden = YES;
		_vwCalendar.hidden = NO;
	}
}

- (void) setVocationDate : (NSMutableArray*)vocations
{
	for (STVocation *voc in vocations) {
		voc.vocation = [NSDate dateWithString:voc.date withFormat:@"yyy-MM-dd hh:mm"];
	}
	[calendarVC setVocations:vocations office:_officeName];
	[listVC setOfficeID:_office_id];
}
#pragma mark - Web Service Relation

- (void) callGetData
{
	// show HUB first time
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	[self callGetOfficesAttendance];
}

/**
 * call get bill list service
 */
- (void) callGetOfficesAttendance
{
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficesAttendance:_office_id];
}

- (void) GetOfficesAttendanceResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];

		[self setVocationDate:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

@end
