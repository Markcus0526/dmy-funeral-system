//
//  LingYuanMainVC.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanMainVC.h"

@interface LingYuanMainVC ()
@property (weak, nonatomic) IBOutlet UIButton *btnTab1;
@property (weak, nonatomic) IBOutlet UIButton *btnTab2;
@property (weak, nonatomic) IBOutlet UIButton *btnTab3;
@property (weak, nonatomic) IBOutlet UILabel *ctrlIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeftIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView1;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (weak, nonatomic) IBOutlet UIWebView *webView3;
@property (weak, nonatomic) IBOutlet UIWebView *webView4;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;

@property (weak, nonatomic) IBOutlet UIView *vwNews;

@end

#define TABCOUNT					3

@implementation LingYuanMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	_vwNews.hidden = YES;
	[self callGetDatas];
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
#pragma mark - Web Service Relation

- (void) callGetDatas
{
//	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	ComSvcMgr * svcMgr = [[ComSvcMgr alloc] init];
	svcMgr.delegate = self;
	[svcMgr GetTombKnowledge];
}

- (void) getTombKnowledgeResult:(NSInteger)retcode retmsg:(NSString *)retmsg buy_tomb_flow:(NSString *)buy_tomb_flow precaution:(NSString *)precaution bury_custom:(NSString *)bury_custom bury_news_url:(NSString *)bury_news_url
{
	if (retcode == SVCERR_SUCCESS)
	{
//		[SVProgressHUD dismiss];
		if (stringNotNilOrEmpty(buy_tomb_flow))
			[_webView1 loadHTMLString:buy_tomb_flow baseURL:nil];
		else
			[_webView1 loadHTMLString:precaution baseURL:nil];
		[_webView2 loadHTMLString:precaution baseURL:nil];
		[_webView3 loadHTMLString:bury_custom baseURL:nil];
		[_webView4 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithUnicodeString:bury_news_url]]];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Scroll Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == _scrollMain)
	{
		CGPoint ptOffset = scrollView.contentOffset;
		int nIndicatorWidth = _ctrlIndicator.frame.size.width;
		int nLeftMargin = (self.view.frame.size.width - nIndicatorWidth * TABCOUNT) / (TABCOUNT - 1);
		int nPageWidth = _scrollMain.frame.size.width;
		
		CGRect rcIndFrame = _ctrlIndicator.frame;
		
		if (ptOffset.x * nIndicatorWidth / nPageWidth < nIndicatorWidth / 2)
		{
			// change indicator position
			rcIndFrame = CGRectMake(ptOffset.x * nIndicatorWidth / nPageWidth, rcIndFrame.origin.y, rcIndFrame.size.width, rcIndFrame.size.height);
			
			// first tab selected
			[_btnTab1 setSelected:YES];
			[_btnTab2 setSelected:NO];
			[_btnTab3 setSelected:NO];
		}
		else if ((ptOffset.x * nIndicatorWidth / nPageWidth >= nIndicatorWidth / 2)
				 && (ptOffset.x * nIndicatorWidth / nPageWidth < (nIndicatorWidth + nIndicatorWidth / 2)))
		{
			// change indicator position
			rcIndFrame = CGRectMake(nLeftMargin + ptOffset.x * nIndicatorWidth / nPageWidth, rcIndFrame.origin.y, rcIndFrame.size.width, rcIndFrame.size.height);
			
			// second tab selected
			[_btnTab1 setSelected:NO];
			[_btnTab2 setSelected:YES];
			[_btnTab3 setSelected:NO];

		}
		else
		{
			// change indicator position
			rcIndFrame = CGRectMake(nLeftMargin + ptOffset.x * nIndicatorWidth / nPageWidth, rcIndFrame.origin.y, rcIndFrame.size.width, rcIndFrame.size.height);
			
			// third tab selected
			[_btnTab1 setSelected:NO];
			[_btnTab2 setSelected:NO];
			[_btnTab3 setSelected:YES];
		}
		
		_ctrlIndicator.frame = rcIndFrame;
	}
}


- (IBAction)onTapTab1:(id)sender
{
	[self moveToTab1:YES];
}

- (IBAction)onTapTab2:(id)sender
{
	// second tab selected
	[_btnTab1 setSelected:NO];
	[_btnTab2 setSelected:YES];
	[_btnTab3 setSelected:NO];
	
	[_scrollMain scrollRectToVisible:CGRectMake(_scrollMain.frame.size.width, 0, _scrollMain.frame.size.width, _scrollMain.frame.size.height) animated:YES];
}

- (IBAction)onTapTab3:(id)sender
{
	// third tab selected
	[_btnTab1 setSelected:NO];
	[_btnTab2 setSelected:NO];
	[_btnTab3 setSelected:YES];
	
	[_scrollMain scrollRectToVisible:CGRectMake(_scrollMain.frame.size.width * 2, 0, _scrollMain.frame.size.width, _scrollMain.frame.size.height) animated:YES];
}

- (void) moveToTab1 : (bool)animated
{
	// first tab selected
	[_btnTab1 setSelected:YES];
	[_btnTab2 setSelected:NO];
	[_btnTab3 setSelected:NO];
	
	[_scrollMain scrollRectToVisible:CGRectMake(0, 0, _scrollMain.frame.size.width, _scrollMain.frame.size.height) animated:animated];
}

- (void) setNewType
{
	_vwNews.hidden = NO;
}

@end
