//
//  ShengHuoDianYingVC.m
//  BinZang
//
//  Created by KimOkChol on 4/18/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoDianYingVC.h"

@interface ShengHuoDianYingVC ()

@end

@implementation ShengHuoDianYingVC

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[self callGetUrl];
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


- (void) updateUI : (NSString *)page_url
{
	[_webContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithUnicodeString:page_url]]];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

- (void) callGetUrl
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetCinemaPageUrl];
}

- (void) getCinemaPageUrlResult:(NSInteger)retcode retmsg:(NSString *)retmsg page_url:(NSString *)page_url
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self updateUI:page_url];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

@end
