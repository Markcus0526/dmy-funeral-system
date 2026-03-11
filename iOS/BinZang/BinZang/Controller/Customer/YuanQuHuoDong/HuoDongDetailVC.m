//
//  HuoDongDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "HuoDongDetailVC.h"

@interface HuoDongDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblActTime;
@property (weak, nonatomic) IBOutlet UIWebView *wvContents;

@end



#define ACTTYPE_OBLATION					1

@implementation HuoDongDetailVC
{
	UIBarButtonItem* buyButton;
}
@synthesize mActInfo;

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

- (void) initControls
{
	buyButton = self.navigationItem.rightBarButtonItem;
	self.navigationItem.rightBarButtonItem = nil;
	[self callReadActivity];
}

/**
 * update UI
 */
- (void) updateUI
{
	[_lblTitle setText:mActInfo.title];
	[_lblTime setText:mActInfo.add_time];
	[_lblActTime setText:mActInfo.act_time];
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:mActInfo.image_url] placeholderImage:DEF_IMAGE];
	borderWidthColor(_imgMain, 1, [UIColor blackColor]);
	[_wvContents loadHTMLString:mActInfo.act_contents baseURL:nil];
	
	// check activity type
	if (mActInfo.is_oblation == ACTTYPE_OBLATION &&
		[Common userInfo].user_type == UserType_JiuKeHu)
	{
		self.navigationItem.rightBarButtonItem = buyButton;
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get activity detail service
 */
- (void) callGetActDetail
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetActDetail:mActInfo.uid];
}

- (void) getActDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STActivity *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mActInfo = datainfo;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

/**
 * call read activity service
 */
- (void) callReadActivity
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ReadActivity:mActInfo.uid];
}

- (void) readActivityResult:(NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self callGetActDetail];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

@end
