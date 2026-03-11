//
//  ShengHuoChuXingVC.m
//  BinZang
//
//  Created by KimOkChol on 4/18/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoChuXingVC.h"

@interface ShengHuoChuXingVC ()

@end

@implementation ShengHuoChuXingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self callGetPlaneUrl];
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


- (void) updateUI : (NSString *)plane_url train_url:(NSString *)train_url
{
	[_webContent1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithUnicodeString:plane_url]]];
	[_webContent2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithUnicodeString:train_url]]];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

- (void) callGetPlaneUrl
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetJournalPageUrl];
}

- (void) getJournalPageUrlResult:(NSInteger)retcode retmsg:(NSString *)retmsg plane_page_url:(NSString *)plane_page_url train_page_url:(NSString *)train_page_url
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self updateUI:plane_page_url train_url:train_page_url];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


- (IBAction)onTapPlane:(id)sender
{
	[_webContent1 setHidden:NO];
	[_webContent2 setHidden:YES];
	[_btnPlane setSelected:YES];
	[_btnTrain setSelected:NO];
}

- (IBAction)onTapTrain:(id)sender
{
	[_webContent1 setHidden:YES];
	[_webContent2 setHidden:NO];
	[_btnPlane setSelected:NO];
	[_btnTrain setSelected:YES];
}

@end
