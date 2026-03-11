//
//  CompanyIntroVC.m
//  BinZang
//
//  Created by KimOkChol on 4/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "CompanyIntroVC.h"

@interface CompanyIntroVC ()

@end

@implementation CompanyIntroVC

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
	[self callGetComanyIntro];
}

/**
 * update UI 
 */
- (void) updateUI : (NSString *)imageUrl contents:(NSString *)contents phone:(NSString *)phone
{
	[_imgMain setImageWithURL:[[NSURL alloc] initWithUnicodeString:imageUrl] placeholderImage:DEF_IMAGE];
	[_webContent loadHTMLString:contents baseURL:nil];
	[_lblPhone setText:phone];
}
///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get company intro
 */
- (void) callGetComanyIntro
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetCompanyIntro];
}

- (void) getCompanyIntroResult:(NSInteger)retcode retmsg:(NSString *)retmsg image_url:(NSString *)image_url contents:(NSString *)contents phone:(NSString *)phone
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self updateUI:image_url contents:contents phone:phone];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


@end
