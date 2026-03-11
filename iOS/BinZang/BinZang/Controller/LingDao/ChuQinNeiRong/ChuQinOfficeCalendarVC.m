//
//  ChuQinOfficeCalendarVC.m
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ChuQinOfficeCalendarVC.h"
#import "ChuQinOfficeDetailVC.h"
#import "FSCalendar.h"
#import "NSDate+String.h"

@interface ChuQinOfficeCalendarVC ()<FSCalendarDataSource, FSCalendarDelegate>
{
	NSString *office_name;
	NSMutableArray *vocations;
	
	NSString *detailTitle;
	
	NSString* monthFormat;
	
}

@property (weak,   nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;

@end

@implementation ChuQinOfficeCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void) setVocations:(NSMutableArray *)voca office:(NSString*)office
{
	vocations = voca;
	office_name = office;
	
	[_calendar reloadData];
}

- (void) initControls
{
//	_calendar.currentDate = [NSDate date];

	monthFormat = @"yyyy年 M月";
	
	_lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
}

- (IBAction)onPrevMonth:(id)sender
{
	[_calendar gotoNextMonth];
	_lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
}

- (IBAction)onNextMonth:(id)sender
{
	[_calendar gotoPrevMonth];
	_lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
}

#pragma mark - FSCalendarDataSource

- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
{
	return nil;
}

- (long)calendar:(FSCalendar *)calendar hasNotifierForDate:(NSDate *)date
{
	long count = 0;
	for (STVocation *voc in vocations) {
		if ([voc.vocation isEqualToDate:date])
			count ++;
	}
	return count;
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
#if 0
	BOOL shouldSelect = date.fs_day != 7;
	if (!shouldSelect) {
		[[[UIAlertView alloc] initWithTitle:@"FSCalendar"
									message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]]
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil, nil] show];
	}
	return shouldSelect;
#endif
	
	if ([date isEqualToDate:[NSDate date]])
	{
		return YES;
	}
	return NO;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
	NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
	
	NSMutableArray *daily = [[NSMutableArray alloc] init];
	for (STVocation *voc in vocations)
	{
		if ([voc.vocation isEqualToDate:date])
		{
			[daily addObject:voc];
		}
	}
	detailTitle = [NSString stringWithFormat:@"'%@' %@ 出勤状态", office_name, [date fs_stringWithFormat:@"yyyy年MM月dd日"]];
	[self performSegueWithIdentifier:@"segueDetail" sender:daily];
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar
{
	NSLog(@"did change to month %@",[calendar.currentMonth fs_stringWithFormat:@"MMMM yyyy"]);
}


#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueDetail"])
	{
		ChuQinOfficeDetailVC *vc = (ChuQinOfficeDetailVC *)segue.destinationViewController;
		
		[vc setDetailInfo:detailTitle vocations:sender];
	}
}


@end
