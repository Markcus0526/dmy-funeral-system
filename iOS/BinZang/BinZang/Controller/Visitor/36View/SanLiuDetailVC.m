//
//  SanLiuDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "SanLiuDetailVC.h"

@interface SanLiuDetailVC ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTitleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContentHeight;
@end

@implementation SanLiuDetailVC

@synthesize mViewInfo;

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
	borderWidthColor(_imgMain, 1, [UIColor grayColor]);
	[self callGetViewDetail];
	_webContents.delegate = self;
}

/**
 * update UI
 */
- (void) updateUI
{
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:mViewInfo.image_url] placeholderImage:DEF_IMAGE];
	[_webContents loadHTMLString:mViewInfo.contents baseURL:nil];
	[_lblTitle setText:mViewInfo.title];
	[_lblTitle sizeToFit];
	if (_lblTitle.frame.size.height > _constraintTitleHeight.constant)
		_constraintTitleHeight.constant = _lblTitle.frame.size.height;
}

#pragma UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
	
	CGRect frame = aWebView.frame;
	//frame.size.height = 1;
	//aWebView.frame = frame;
	
	CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
	frame.size = fittingSize;
	aWebView.frame = frame;
	
	_constraintContentHeight.constant = fittingSize.height;
	
	NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get 36 view detail service
 */
- (void) callGetViewDetail
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] Get36ViewDetail:mViewInfo.uid];
}

- (void) get36ViewDetail:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(ST36View *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mViewInfo = datainfo;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


@end
