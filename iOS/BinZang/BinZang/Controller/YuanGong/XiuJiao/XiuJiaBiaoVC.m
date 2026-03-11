//
//  XiuJiaBiaoVC.m
//  BinZang
//
//  Created by Beids on 5/10/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "XiuJiaBiaoVC.h"
#import "FSCalendar.h"
#import "NSDate+String.h"

@interface XiuJiaBiaoVC ()<FSCalendarDataSource, FSCalendarDelegate>
{
    NSString* monthFormat;
    NSMutableArray *arrItems;
}
@end

@implementation XiuJiaBiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self callGetVocationDates];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initControls
{
    //	_calendar.currentDate = [NSDate date];
    
    monthFormat = @"yyyy年 M月";
    
    _lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
    
    _btnCancel.layer.borderColor = [UIColor blackColor].CGColor;
    _btnCancel.layer.borderWidth = 1.0f;
    _btnCancel.layer.cornerRadius = 5;
    
    [_btnCancel addTarget:self action:@selector(setHighlighted:) forControlEvents:UIControlEventTouchDown];
    
    
}

- (void) callGetVocationDates
{
    arrItems = nil;
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetVocationDates];
}


- (void) getVocationDatesResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

- (void) updateUI : (NSMutableArray *)newItems
{
    if (arrItems != nil)
    {
        [arrItems removeAllObjects];
    }
    else
        arrItems = [[NSMutableArray alloc] init];
    
    if([newItems count] > 0)
    {
        for ( int i = 0; i < newItems.count; i++ )
        {
            STYVocation *styData = (STYVocation*)[newItems objectAtIndex:i];
            if ( styData.state == 0 )
                [arrItems addObject:styData];
        }        
        //calendar.re
    }
    [_calendar reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"asdga"])
    {
        // get current office data
        UIButton * button = (UIButton *)sender;
        
    }
}

-(void)setHighlighted:(BOOL)highlighted
{
    // Do original Highlight
    //[super setHighlighted:highlighted];
    
    // Highlight with new colour OR replace with orignial
 
         _btnCancel.backgroundColor = [UIColor darkGrayColor];
}

- (IBAction)OnCancelButtonTouchUpOutside:(id)sender {
    _btnCancel.backgroundColor = [UIColor whiteColor];
}

- (IBAction)OnCancelButtonTouchUpInside:(id)sender {
    _btnCancel.backgroundColor = [UIColor whiteColor];
}

- (IBAction)OnNextMonth:(id)sender {
    [_calendar gotoPrevMonth];
    _lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
}

- (IBAction)OnPrevMonth:(id)sender {
    [_calendar gotoNextMonth];
    _lblMonth.text = [[_calendar currentMonth] toStringWithFormat:monthFormat];
}

- (long)calendar:(FSCalendar *)calendar hasNotifierForDate:(NSDate *)date
{
    long count = 0;
    
    for ( int i = 0; i < arrItems.count; i++ )
    {
        STYVocation *styData = (STYVocation*)[arrItems objectAtIndex:i];
        if ( [styData.vocation isEqualToDate:date] )
        {
            count = -3;
            break;
        }
    }
   
    /*
    for (STVocation *voc in vocations) {
        if ([voc.vocation isEqualToDate:date])
            count ++;
    }
     */
    return count;
}


@end
