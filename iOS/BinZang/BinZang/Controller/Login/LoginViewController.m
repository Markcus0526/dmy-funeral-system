//
//  LoginViewController.m
//  FSSystem
//
//  Created by Kim Ok Chol on 1/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LoginViewController.h"
#import "Config.h"
#import "APService.h"

@interface LoginViewController ()
@end


#define SEGUE_TO_MAIN					@"segueFromLoginToCusMain"

@implementation LoginViewController

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

///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

/**
 * Initilaize all ui controls & member variable
 */
- (void) initControls
{
	// init input controls
	[self initInputControls];
	
	roundRect(_btnLogin, DEF_CORNER_RADIO);
	roundRect(_vwUsername, DEF_CORNER_RADIO);
	roundRect(_vwPassword, DEF_CORNER_RADIO);
	borderWidthColor(_vwUsername, 0.5, [UIColor blackColor]);
	borderWidthColor(_vwPassword, 0.5, [UIColor blackColor]);
	
	// load saved userinfo
	if (stringNotNilOrEmpty([Config loginName])) {
		[_txtUsername setText:[Config loginName]];
		[_txtPassword setText:[Config loginPassword]];
		
		[_btnCheckBox setSelected:YES];
	}
	
	[self initJPush];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call register service
 */
- (void) callLogin : (NSString *)username password:(NSString *)pwd
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] LoginUser:username password:pwd];
}

- (void) loginUserResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STUserInfo *)datainfo
{
	if (retcode == SVCERR_SUCCESS) {
		
		[SVProgressHUD dismiss];
		
		[self saveUserInfo:datainfo];
		
//		// clear text box
//		[_txtUsername setText:@""];
//		[_txtPassword setText:@""];
		
		// set tag for jPush
		[self setTagsAlias:[Common strUserId]];

		// go to main view controller
		[self performSegueWithIdentifier:SEGUE_TO_MAIN sender:self];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) saveUserInfo : (STUserInfo *)userinfo
{
	[Common setUserInfo:userinfo];

	if ([_btnCheckBox isSelected])
	{
		[Config setLoginName:[_txtUsername text]];
		[Config setLoginPassword:[_txtPassword text]];
	}
	else
	{
		[Config setLoginName:@""];
		[Config setLoginPassword:@""];
	}
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - UI Control Event

- (IBAction)onTapLogin:(id)sender
{
#if 1
	if (!stringNotNilOrEmpty([_txtUsername text]))
	{
		showToast(MSG_INPUT_PHONENUM);
		[_txtUsername becomeFirstResponder];
		return;
	}
	if (!stringNotNilOrEmpty([_txtPassword text]))
	{
		showToast(MSG_INPUT_PASSWORD);
		[_txtPassword becomeFirstResponder];
		return;
	}
	
	[self callLogin:[_txtUsername text] password:[_txtPassword text]];
#else
	[self saveUserInfo:nil];
	
	// go to main view controller
	[self performSegueWithIdentifier:SEGUE_TO_MAIN sender:self];

#endif
}

- (IBAction)onTapCheckBox:(id)sender
{
	[_btnCheckBox setSelected:![_btnCheckBox isSelected]];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - JPush Relation

- (void)initJPush
{
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter addObserver:self
					  selector:@selector(networkDidSetup:)
						  name:kJPFNetworkDidSetupNotification
						object:nil];
	[defaultCenter addObserver:self
					  selector:@selector(networkDidClose:)
						  name:kJPFNetworkDidCloseNotification
						object:nil];
	[defaultCenter addObserver:self
					  selector:@selector(networkDidRegister:)
						  name:kJPFNetworkDidRegisterNotification
						object:nil];
	[defaultCenter addObserver:self
					  selector:@selector(networkDidLogin:)
						  name:kJPFNetworkDidLoginNotification
						object:nil];
	[defaultCenter addObserver:self
					  selector:@selector(networkDidReceiveMessage:)
						  name:kJPFNetworkDidReceiveMessageNotification
						object:nil];
	[defaultCenter addObserver:self
					  selector:@selector(serviceError:)
						  name:kJPFServiceErrorNotification
						object:nil];
	
	//	// Do any additional setup after loading the view from its nib.
	//#pragma clang diagnostic push
	//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	//	_UDIDValueLabel.text = [APService openUDID];
	//#pragma clang diagnostic pop
	//	_UDIDValueLabel.textColor = [UIColor colorWithRed:0.0 / 255
	//												green:122.0 / 255
	//												 blue:255.0 / 255
	//												alpha:1];
	//	_registrationValueLabel.text = [APService registrationID];
	//	_registrationValueLabel.textColor = [UIColor colorWithRed:0.0 / 255
	//														green:122.0 / 255
	//														 blue:255.0 / 255
	//														alpha:1];
	// show appKey
	NSString *appKey = [self getAppKey];
	if (appKey) {
		//		_appKeyLabel.text = appKey;
		//		_appKeyLabel.textColor = [UIColor colorWithRed:0.0 / 255
		//												 green:122.0 / 255
		//												  blue:255.0 / 255
		//												 alpha:1];
	}
}

//获取appKey
- (NSString *)getAppKey {
	NSURL *urlPushConfig = [[[NSBundle mainBundle] URLForResource:@"PushConfig"
													withExtension:@"plist"] copy];
	NSDictionary *dictPushConfig =
	[NSDictionary dictionaryWithContentsOfURL:urlPushConfig];
	
	if (!dictPushConfig) {
		return nil;
	}
	
	// appKey
	NSString *strApplicationKey = [dictPushConfig valueForKey:(@"APP_KEY")];
	if (!strApplicationKey) {
		return nil;
	}
	
	return [strApplicationKey lowercaseString];
}


- (void)networkDidSetup:(NSNotification *)notification {
	NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
	NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
	NSLog(@"%@", [notification userInfo]);
	NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
	NSLog(@"已登录");
	
	if ([APService registrationID]) {
		NSString * regId = [APService registrationID];
		NSLog(@"get RegistrationID");
	}
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSString *title = [userInfo valueForKey:@"title"];
	NSString *content = [userInfo valueForKey:@"content"];
	NSDictionary *extra = [userInfo valueForKey:@"extras"];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
	
	NSString *currentContent = [NSString
								stringWithFormat:
								@"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
								[NSDateFormatter localizedStringFromDate:[NSDate date]
															   dateStyle:NSDateFormatterNoStyle
															   timeStyle:NSDateFormatterMediumStyle],
								title, content, [self logDic:extra]];
	NSLog(@"%@", currentContent);
	
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
	if (![dic count]) {
		return nil;
	}
	NSString *tempStr1 =
	[[dic description] stringByReplacingOccurrencesOfString:@"\\u"
												 withString:@"\\U"];
	NSString *tempStr2 =
	[tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	NSString *tempStr3 =
	[[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
	NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
	NSString *str =
	[NSPropertyListSerialization propertyListFromData:tempData
									 mutabilityOption:NSPropertyListImmutable
											   format:NULL
									 errorDescription:NULL];
	return str;
}

- (void)serviceError:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSString *error = [userInfo valueForKey:@"error"];
	NSLog(@"%@", error);
}


//////////////////////////////////////////////////////////////////////////////
#pragma mark - JPush Set Tag

- (void)setTagsAlias : (NSString *)pushTag
{
	NSMutableSet *tags = [NSMutableSet set];
	
	[self setTags:&tags addTag:pushTag];
	
	[APService setTags:tags
				 alias:nil
	  callbackSelector:@selector(tagsAliasCallback:tags:alias:)
				target:self];
	
	//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置"
	//													message:@"已发送设置"
	//												   delegate:self
	//										  cancelButtonTitle:@"确定"
	//										  otherButtonTitles:nil, nil];
	//	[alert show];
}


- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
	//  if ([tag isEqualToString:@""]) {
	// }
	[*tags addObject:tag];
}


- (void)tagsAliasCallback:(int)iResCode
					 tags:(NSSet *)tags
					alias:(NSString *)alias {
	NSString *callbackString =
	[NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
	 [self logSet:tags], alias];
	//	if ([_callBackTextView.text isEqualToString:@"服务器返回结果"]) {
	//		_callBackTextView.text = callbackString;
	//	} else {
	//		_callBackTextView.text = [NSString
	//								  stringWithFormat:@"%@\n%@", callbackString, _callBackTextView.text];
	//	}
	NSLog(@"TagsAlias回调:%@", callbackString);
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logSet:(NSSet *)dic {
	if (![dic count]) {
		return nil;
	}
	NSString *tempStr1 =
	[[dic description] stringByReplacingOccurrencesOfString:@"\\u"
												 withString:@"\\U"];
	NSString *tempStr2 =
	[tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	NSString *tempStr3 =
	[[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
	NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
	NSString *str =
	[NSPropertyListSerialization propertyListFromData:tempData
									 mutabilityOption:NSPropertyListImmutable
											   format:NULL
									 errorDescription:NULL];
	return str;
}


@end
