//
//  ForgetPasswordVC.m
//  BinZang
//
//  Created by KimOkChol on 5/11/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *roundView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *borderViews;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfPassword;

@end

@implementation ForgetPasswordVC

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
	for (UIView *view in _roundView)
	{
		roundRect(view, DEF_CORNER_RADIO);
	}
	for (UIView *view in _borderViews)
	{
		borderWidthColor(view, 0.5, [UIColor darkGrayColor]);
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
- (IBAction)onTapChangePasswd:(id)sender
{
	if (!stringNotNilOrEmpty(_txtUserName.text))
	{
		showToast(@"请输入用户名");
		[_txtUserName becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty(_txtPhoneNumber.text))
	{
		showToast(@"请输入手机号码");
		[_txtPhoneNumber becomeFirstResponder];
		return;
	}
	if ([_txtPhoneNumber.text length] != 11)
	{
		showToast(@"手机号码必须为11位数字");
		[_txtPhoneNumber becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty(_txtPassword.text))
	{
		showToast(@"请输入新密码");
		[_txtPassword becomeFirstResponder];
		return;
	}
	if ([_txtPhoneNumber.text length] < 6 || [_txtPhoneNumber.text length] > 16)
	{
		showToast(@"密码必须为6-16位之间");
		[_txtPhoneNumber becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty(_txtConfPassword.text))
	{
		showToast(@"请输入确认密码");
		[_txtConfPassword becomeFirstResponder];
		return;
	}
	if (![_txtPassword.text isEqualToString:_txtConfPassword.text])
	{
		showToast(@"确认密码不一致");
		[_txtConfPassword becomeFirstResponder];
		return;
	}

	[self callForgotPassword:_txtUserName.text phone:_txtPhoneNumber.text
					password:_txtPassword.text];
	
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call register service
 */
- (void) callForgotPassword : (NSString *)username phone:(NSString *)phone password:(NSString *)password
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ForgetPassword:username phone:phone new_password:password];;
}

- (void) forgotPasswordResult:(NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS) {
		
		[SVProgressHUD dismiss];
		
		[self onTapBack:self];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

@end
