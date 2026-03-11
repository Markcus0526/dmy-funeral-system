//
//  JiangJinJiSuanVC.m
//  BinZang
//
//  Created by KimOkChol on 4/29/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "JiangJinJiSuanVC.h"

@interface JiangJinJiSuanVC ()
{
	double Discount_limit;
	double Commission;
	double Tax_rate;
}
@property (weak, nonatomic) IBOutlet UIView *vwRound1;
@property (weak, nonatomic) IBOutlet UIView *vwRound2;
@property (weak, nonatomic) IBOutlet UIView *vwRound3;
@property (weak, nonatomic) IBOutlet UIView *vwRound4;
@property (weak, nonatomic) IBOutlet UIButton *vwButton1;
@property (weak, nonatomic) IBOutlet UIButton *vwButton2;

@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtPercent;
@property (weak, nonatomic) IBOutlet UITextField *txtBonus;
@property (weak, nonatomic) IBOutlet UITextField *txtResult;

@end

@implementation JiangJinJiSuanVC

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

#pragma mark - Service Functions
- (void) callGetBonusFormula
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetBonusFormula];
}

- (void) getBonusFormulaResult		: (NSInteger)retcode retmsg:(NSString *)retmsg discount:(double)discount_limit commission:(double) commission tax_rate:(double)tax_rate;
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		Discount_limit = discount_limit;
		Commission = commission;
		Tax_rate = tax_rate;
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


#pragma mark - Utilities
-(void) initControls
{
	roundRect(_vwRound1, DEF_CORNER_RADIO);
	borderWidthColor(_vwRound1, 1, [UIColor blackColor]);
	roundRect(_vwRound2, DEF_CORNER_RADIO);
	borderWidthColor(_vwRound2, 1, [UIColor blackColor]);
	roundRect(_vwRound3, DEF_CORNER_RADIO);
	borderWidthColor(_vwRound3, 1, [UIColor blackColor]);
	roundRect(_vwRound4, DEF_CORNER_RADIO);
	borderWidthColor(_vwRound4, 1, [UIColor blackColor]);

	roundRect(_vwButton1, DEF_CORNER_RADIO);
	roundRect(_vwButton2, DEF_CORNER_RADIO);
	
	[self callGetBonusFormula];
}

- (IBAction)tapCalculate:(id)sender
{
	if (!stringNotNilOrEmpty(_txtPrice.text))
	{
		showToast(MSG_INPUT_PRICE);
		[_txtPrice becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty(_txtPercent.text))
	{
		showToast(MSG_INPUT_PERCENT);
		[_txtPercent becomeFirstResponder];
		return;
	}
	
	double price, discount;
	price = [_txtPrice.text doubleValue];
	if (price <= 0)
	{
		showToast(MSG_ALART_PRICE);
		[_txtPrice becomeFirstResponder];
		return;
	}
	
	discount = [_txtPercent.text doubleValue];
	if (discount >= 100 || discount < 0)
	{
		showToast(MSG_ALART_PERCENT);
		[_txtPercent becomeFirstResponder];
		return;
	}
	
	if (discount < Discount_limit)
	{
		showToast(MSG_MESSAGE_NOBONUS);
		[_txtPercent becomeFirstResponder];
		return;
	}
	
	double notax_value = price * (discount / 100) * (Commission / 100);
	double tax_value = notax_value * Tax_rate;
	
	_txtBonus.text = [NSString stringWithFormat:@"%.2f元", notax_value];
	_txtResult.text = [NSString stringWithFormat:@"%.2f元", tax_value];
}


- (IBAction)tapReset:(id)sender
{
	_txtBonus.text = @"";
	_txtPrice.text = @"";
	_txtPercent.text = @"";
	_txtResult.text = @"";
	[_txtPrice becomeFirstResponder];
}

@end
