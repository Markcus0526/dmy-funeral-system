//
//  ShengHuoJingDianDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/20/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoJingDianDetailVC.h"

@interface ShengHuoJingDianDetailVC ()

@end

@implementation ShengHuoJingDianDetailVC

@synthesize mDetailInfo;

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


- (void) initControls
{
	borderWidthColor(_imgMain, 1, [UIColor grayColor]);
	
	[self callGetJingdianDetail];
}

- (void) updateUI
{
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:mDetailInfo.image_url] placeholderImage:DEF_IMAGE];
	[_lblAddress setText:mDetailInfo.address];
	[_lblPhone setText:mDetailInfo.phone];
	[_webContent loadHTMLString:mDetailInfo.contents baseURL:nil];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get jingdian detail info service
 */
- (void) callGetJingdianDetail
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetMtQiPanDetail:mDetailInfo.uid];
}

- (void) getMTQiPanDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STMtQiPan *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mDetailInfo = datainfo;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


@end
