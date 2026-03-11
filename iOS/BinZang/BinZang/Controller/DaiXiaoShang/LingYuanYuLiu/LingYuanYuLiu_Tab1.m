//
//  LingYuanYuLiu_Tab1.m
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanYuLiu_Tab1.h"
#import "LingYuanYuLiuNavi.h"

@interface LingYuanYuLiu_Tab1 ()
@property (weak, nonatomic) IBOutlet UITextField *txtMasterName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName1;
@property (weak, nonatomic) IBOutlet UITextField *txtCareName1;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName2;
@property (weak, nonatomic) IBOutlet UITextField *txtCareName2;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;
@end

#define SEGUE_TO_DETAIL	@"segueLingYuanYuLiuNext"

@implementation LingYuanYuLiu_Tab1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	roundRect(_btnCancel, DEF_CORNER_RADIO);
	roundRect(_btnOK, DEF_CORNER_RADIO);
	borderWidthColor(_btnCancel, 0.5, [UIColor lightGrayColor]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
	{
		LingYuanYuLiu_Tab1 *view = segue.destinationViewController;
		if (view && [view respondsToSelector:@selector(setTokenData:)])
		{
			[view setTokenData:_tokenData];
		}
	}
}

#pragma mark - Utilities

- (IBAction)onNext:(id)sender
{
	//check input data
	if (!stringNotNilOrEmpty(_txtMasterName.text))
	{
		showToast(@"请输入用户名。");
		[_txtMasterName becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty(_txtPhoneNumber.text))
	{
		showToast(@"请输入用户手机号码。");
		[_txtPhoneNumber becomeFirstResponder];
		return;
	}
	
	if (!stringNotNilOrEmpty(_txtUserName1.text) && !stringNotNilOrEmpty(_txtUserName2.text))
	{
		showToast(@"请输入至少一个末者名称。");
		[_txtUserName1 becomeFirstResponder];
		return;
	}else if (stringNotNilOrEmpty(_txtUserName1.text) && !stringNotNilOrEmpty(_txtCareName1.text))
	{
		showToast(@"请输入抚慰人名称。");
		[_txtCareName1 becomeFirstResponder];
		return;
	}
	else if (stringNotNilOrEmpty(_txtCareName2.text) && !stringNotNilOrEmpty(_txtCareName2.text))
	{
		showToast(@"请输入抚慰人名称。");
		[_txtCareName2 becomeFirstResponder];
		return;
	}
	
	//validating checking MasterName from Service
	
	//temp
	[self checking:0];
}

- (IBAction)onCancel:(id)sender
{
	LingYuanYuLiuNavi *navigation = (LingYuanYuLiuNavi*)self.navigationController;
	[navigation onCancel:self];
	
}

-(void) checking : (NSInteger)userid
{
	if (!_tokenData)
	{
		_tokenData = [[NSMutableDictionary alloc] init];
	}
	[_tokenData setObject:_txtMasterName.text forKey:@"customer_name"];
	[_tokenData setObject:_txtPhoneNumber.text forKey:@"customer_phone"];
	[_tokenData setObject:_txtUserName1.text forKey:@"death_people1"];
	[_tokenData setObject:_txtCareName1.text forKey:@"mgr_people1"];
	
	if (stringNotNilOrEmpty(_txtUserName2.text))
	{
		[_tokenData setObject:_txtUserName2.text forKey:@"death_people2"];
		[_tokenData setObject:_txtCareName2.text forKey:@"mgr_people2"];
	}
	[self performSegueWithIdentifier:SEGUE_TO_DETAIL sender:_tokenData];
}
@end
