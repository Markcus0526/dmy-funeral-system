//
//  YiShiYuYueVC.m
//  BinZang
//
//  Created by Admin on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "YiShiYuYueVC.h"
#import "YiShiYuYueServiceVC.h"
#import "JiBaiYuYueProductVC.h"
#import "DaixiaoshangShouyeVC.h"
#import "MIConfirmViewController.h"
#import "MIActionSheet.h"

@interface YiShiYuYueVC ()<MIConfirmDelegate, MISelectorDelegate>
{
	MIActionSheet*      actionSheet;
	MIObjectPickerView* objPicker;
	
	NSMutableArray *	arrItems;
	NSMutableArray *	arrTombs;
	
	long				nCurTombId;
}

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *mShowingLabel;

@property (weak, nonatomic) IBOutlet UIView *vwDaiJiBai;
@property (weak, nonatomic) IBOutlet UIView *vwBuyInfo;
@property (weak, nonatomic) IBOutlet UIView *vwInfoName;
@property (weak, nonatomic) IBOutlet UIView *vwInfoPhone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBuyInfoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintUpperGapHeight;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;

@property (weak, nonatomic) IBOutlet UITextField *txtCustomerName;
@property (weak, nonatomic) IBOutlet UITextField *txtCustomerPhone;

@property (nonatomic, retain) NSMutableDictionary *tokenData;

@end


#define SEGUE_TO_YISHI				@"segueFromBinZhangYiShi1To2"
#define SEGUE_TO_JIBAI				@"segueFromBinZhangYiShi1To3"

@implementation YiShiYuYueVC

@synthesize mDatePicker;

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
	roundRect(_vwInfoName, DEF_CORNER_RADIO);
	roundRect(_vwInfoPhone, DEF_CORNER_RADIO);
	borderWidthColor(_vwInfoPhone, 0.5, [UIColor darkGrayColor]);
	borderWidthColor(_vwInfoName, 0.5, [UIColor darkGrayColor]);
	
	borderWidthColor(_btnCancel, 0.5, [UIColor darkGrayColor]);
	roundRect(_btnCancel, DEF_CORNER_RADIO);
	roundRect(_btnNext, DEF_CORNER_RADIO);
	
	[mDatePicker setMinimumDate:[NSDate date]];
	[self ChangeDateTimeLabel:[NSDate date]];
	
	if (self.isAgent)
	{
		if (self.need_bury_service)
		{
			self.navigationItem.title = @"代订祭品购买";
		}
		else{
			self.navigationItem.title = @"代预约落葬仪式";
		}

		_checkBox.selected = NO;
		_vwDaiJiBai.hidden = YES;
		[self callGetCustomerList];
	}
	else
	{
		if (self.need_bury_service)
		{
			self.navigationItem.title = @"祭拜预约";
		}
		else{
			self.navigationItem.title = @"落葬仪式预约";
			_checkBox.selected = NO;
			_vwDaiJiBai.hidden = YES;
		}

		_vwBuyInfo.hidden = YES;
		_constraintBuyInfoHeight.constant = 40;
		
		[self callGetTombListForCustomer];
	}
}

- (IBAction)ChangedDateTime:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)sender;
	
	[self ChangeDateTimeLabel:picker.date];
}

- (void) ChangeDateTimeLabel : (NSDate *)dt
{
    NSString *dateString = [GlobalFunc convertDateToString:dt fmt:nil];
   [_mShowingLabel setText:dateString];
}

- (void) onAgentNext
{
	//check customer information
	if (arrItems.count <= 0)
	{
		showToast(@"抱歉，现在没有用户信息，暂时不能预约");
		return;
	}
	
	if (!stringNotNilOrEmpty(_txtCustomerName.text))
	{
		showToast(@"请输入用户名");
		[_txtCustomerName becomeFirstResponder];
		return;
	}
	else if (!stringNotNilOrEmpty(_txtCustomerPhone.text))
	{
		showToast(@"请输入用户手机号码");
		[_txtCustomerPhone becomeFirstResponder];
		return;
	}
	
	STCustomer *customer = nil;
	for (STCustomer *cus in arrItems)
	{
		if ([cus.name isEqualToString:_txtCustomerName.text] && [cus.phone isEqualToString:_txtCustomerPhone.text])
		{
			customer = cus;
			break;
		}
		
	}
	if (!customer)
	{
		showToast(@"用户信息不符合, 请查看！");
		return;
	}
	
	//
	[self setTombList:customer.tombs];
		
	[objPicker setValues:arrTombs];
		
	[actionSheet setPickerValue:objPicker value:@""];
	[actionSheet showActionSheet];
}

- (void) onCustomerNext
{
	[objPicker setValues:arrTombs];
		
	[actionSheet setPickerValue:objPicker value:@""];
	[actionSheet showActionSheet];
}
- (IBAction)onTapOK:(id)sender
{
	if (_isAgent)
	{
		[self onAgentNext];
	}
	else
	{
		[self onCustomerNext];
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

- (IBAction)onTapCheck:(id)sender
{
	_checkBox.selected = !_checkBox.selected;
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

- (void) setTombList : (NSMutableArray *)tomblist
{
	arrTombs = tomblist;
	
	actionSheet = [[MIActionSheet alloc]init];
	actionSheet.delegate = self;
	objPicker = [[MIObjectPickerView alloc] init];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Selector Delegate
- (void) okSelector:(long)index value:(NSString *)value
{
	nCurTombId = [(STTombInfo *)[arrTombs objectAtIndex:index] uid];
	
	if (_need_bury_service)
		[self performSegueWithIdentifier:SEGUE_TO_JIBAI sender:nil ];
	else
	{
		[self performSegueWithIdentifier:SEGUE_TO_YISHI sender:nil];
	}

}

#pragma mark - Web Service Relation

/**
 * call get qingren list service
 */
- (void) callGetTombListForCustomer
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetTombListForCustomer];
}

- (void) getTombListForCusResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self setTombList : datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) callGetCustomerList
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetCustomerList];
}

- (void) GetCustomerListResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		arrItems = datalist;
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if (!_tokenData)
	{
		_tokenData = [[NSMutableDictionary alloc] init];
	}
	
	[_tokenData setObject:[NSNumber numberWithBool:_isAgent] forKey:@"IsAgent"];
	[_tokenData setObject:[NSNumber numberWithBool:_need_bury_service] forKey:@"NeedBuryService"];
	[_tokenData setObject:_mShowingLabel.text forKey:@"ReserveDate"];
	
	if (_isAgent)
	{
		[_tokenData setObject:_txtCustomerName.text forKey:@"CustomerName"];
		[_tokenData setObject:_txtCustomerPhone.text forKey:@"CustomerPhone"];
	}else
	{
		[_tokenData setObject:[NSNumber numberWithBool:_checkBox.selected] forKey:@"DaiJiBai"];
	}
	
	[_tokenData setObject:[NSNumber numberWithLong:nCurTombId] forKey:@"TombID"];
	if (_need_bury_service)
	{
		[_tokenData setObject:STR_JIBAI forKey:@"StrType"];
	}
	else{
		[_tokenData setObject:STR_BINZANG forKey:@"StrType"];
	}
	
	if ([segue.identifier isEqualToString:SEGUE_TO_YISHI])
	{
		// set data
		YiShiYuYueServiceVC * destCtrl = (YiShiYuYueServiceVC *)segue.destinationViewController;
		
		destCtrl.tokenData = _tokenData;
		
	}else if ([segue.identifier isEqualToString:SEGUE_TO_JIBAI])
	{
		JiBaiYuYueProductVC * destCtrl = (JiBaiYuYueProductVC *)segue.destinationViewController;
		
		destCtrl.tokenData = _tokenData;
	}
}


@end
