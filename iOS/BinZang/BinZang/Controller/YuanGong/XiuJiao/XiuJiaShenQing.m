//
//  XiuJiaShenQing.m
//  BinZang
//
//  Created by Beids on 5/11/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "XiuJiaShenQing.h"

@interface XiuJiaShenQing ()
{
    int nReasonState;
    NSMutableArray *			arrItems;
}

@end

@implementation XiuJiaShenQing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InitControls];
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

- (IBAction)OnChangedDate:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    [self ChangeDateTimeLabel:picker.date];
    
    
    
}

-(void) InitControls
{
    [self ChangeDateTimeLabel:[NSDate date]];
    nReasonState = 0;
    [self ChangeOptionImage];
    
    borderWidthColor(_vwOptions, 1, [UIColor darkGrayColor]);
}

- (void) ChangeDateTimeLabel : (NSDate *)dt
{
    NSString *dateString = [GlobalFunc convertODateToString:dt fmt:nil];
    [_lblDate setText:dateString];
}



- (void) updateUI : (NSMutableArray *)newItems
{
    if([newItems count] > 0)
    {
        if (arrItems == nil)
        {
            // arrItems = newItems;
            
            arrItems = [[NSMutableArray alloc] init];
            for ( int i = 0; i < newItems.count; i++ )
            {
                STYVocation *styData = (STYVocation*)[newItems objectAtIndex:i];
                if ( styData.state == 0 )
                    [arrItems addObject:styData];
            }
        }
    }
    
}

- (void) ChangeOptionImage
{
    if ( nReasonState == 0 )
    {
        _imgNormal.highlighted = YES;
        _imgIll.highlighted = NO;
        _imgOther.highlighted = NO;
    }
    else if ( nReasonState == 1 )
    {
        _imgNormal.highlighted = NO;
        _imgIll.highlighted = YES;
        _imgOther.highlighted = NO;
    }
    else
    {
        _imgNormal.highlighted = NO;
        _imgIll.highlighted = NO;
        _imgOther.highlighted = YES;
    }
}

- (IBAction)OnClickSubmit:(id)sender {
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    [self callSubmitVocation];
}

- (IBAction)OnClickLieXiu:(id)sender {
    nReasonState = 0;
    [self ChangeOptionImage];
}

- (IBAction)OnClickBingXiu:(id)sender {
    nReasonState = 1;
    [self ChangeOptionImage];
}

- (IBAction)OnClickQiTa:(id)sender {
    nReasonState = 2;
    [self ChangeOptionImage];
}

- (void) callSubmitVocation
{
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] SubmitVocation : nReasonState voc_date:[_lblDate text]];
}
- (void) submitVocationResult: (NSInteger)retcode retmsg:(NSString *)retmsg
{
    if (retcode == SVCERR_SUCCESS)
    {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}
@end
