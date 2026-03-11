//
//  LingDaoShouYueViewController.m
//  BinZang
//
//  Created by KimOkChol on 5/4/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingDaoShouYueViewController.h"
#import "UIView+ScreenShot.h"
#import "MainViewController.h"
#import "HuoDongDetailVC.h"
#import "LingDaoYeJiVC.h"

@interface LingDaoShouYueViewController ()
{
	NSMutableArray *				arrAdverts;
	NSMutableArray *				arrRelatives;
	
	NSMutableArray *				orgAdverts;
	NSMutableArray *				orgRelatives;
	
	SGFocusImageFrame *             _bannerView;
	NSMutableArray *	            bannerImages;
	
	NSTimer *						mTimerBanner;
	BOOL							isAliveTimer;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

#define CHKBANNER_TIME_DELAY				60
@implementation LingDaoShouYueViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self initControls];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (mTimerBanner != nil)
	{
		[mTimerBanner invalidate];
		mTimerBanner = nil;
	}
	
	isAliveTimer = YES;
	mTimerBanner = [NSTimer scheduledTimerWithTimeInterval:CHKBANNER_TIME_DELAY target:self selector:@selector(callGetBannerImages) userInfo:nil repeats:YES];
	[mTimerBanner fire];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	isAliveTimer = NO;
	if (mTimerBanner != nil)
	{
		[mTimerBanner invalidate];
		mTimerBanner = nil;
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

/**
 * Initilaize all ui controls & member variable
 */
- (void) initControls
{
	// set swipe next view controller : MainViewController
	MainViewController *mainVC = [MainViewController shareInstance];
	[mainVC setPartnerViewController:self];
	[self setNextViewController:mainVC];
	
	UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_switch_sel"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(pushNextViewController:)];
	
	UIButton *btnMark = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
	[btnMark setBackgroundImage:[UIImage imageNamed:@"icon_title"] forState:UIControlStateNormal];
	
	UIBarButtonItem *btnBack1 = [[UIBarButtonItem alloc] initWithCustomView:btnMark];
	
	self.navigationItem.leftBarButtonItems = @[btnBack, btnBack1];
	
	for (UIButton *btn in _buttons)
	{
		borderWidthColor(btn, 1, [UIColor colorWithRed:1 green:1 blue:153.f/255.f alpha:1]);
	}
}


- (void) loadAdvertiseView
{
	// check banner count
	if ((orgAdverts.count + orgRelatives.count) < 1)
		return;
	
	// banner image data list
	bannerImages = [[NSMutableArray alloc] init];
	NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:(orgAdverts.count + orgRelatives.count + 2)];
	
	if (orgAdverts.count > 0 )
	{
		// add one for chain
		STAdvertImage *aBanner = [orgAdverts objectAtIndex:orgAdverts.count - 1];
		[bannerImages addObject:aBanner.image_url];
		
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSString stringWithFormat:@"title%d", -1], @"title",
							  @"0", @"type",
							  nil];
		SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1];
		[itemArray addObject:item];
		
		for (int i = 0; i < orgAdverts.count - 1; i++)
		{
			STBannerImg *aBanner = [orgAdverts objectAtIndex:i];
			[bannerImages addObject:aBanner.image_url];
			
			// make item data
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSString stringWithFormat:@"title%d", i], @"title",
								  @"0", @"type",
								  nil];
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i];
			[itemArray addObject:item];
		}
		
		NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSString stringWithFormat:@"title%lu", orgAdverts.count - 1], @"title",
							   @"0", @"type",
							   nil];
		SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithDict:dict1 tag:orgAdverts.count-1];
		[itemArray addObject:item1];
		NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"title0", @"title",
							   @"0", @"type",
							   nil];
		SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithDict:dict2 tag:-1];
		[itemArray addObject:item2];
	}
	
	UIImage * defImage = DEF_IMAGE;
	
	_bannerView = [[SGFocusImageFrame alloc] initOnOfflieWithFrame:CGRectMake(0, 0, _vwSliderContainer.frame.size.width, _vwSliderContainer.frame.size.height) delegate:self imageItems:itemArray isAuto:YES array:bannerImages defImage:defImage];
	[_bannerView setPageControllerColor:[UIColor lightGrayColor] currectColor:[Common getAppColor]];
	[_bannerView scrollToIndex:0];
	
	[_vwSliderContainer addSubview:_bannerView];
}

#pragma mark - Image Slider Delegate
- (void) foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index
{
	
}

- (void) foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
	MyLog(@"%ld", (long)item.tag);
	
	STBannerImg * bannerInfo = (STBannerImg *)[orgAdverts objectAtIndex:item.tag];
	// go to 36view
	HuoDongDetailVC * destVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HuoDongDetailVC"];
	STActivity * info = [[STActivity alloc] init];
	info.uid = bannerInfo.uid;
	destVC.mActInfo = info;
	[self.navigationController pushViewController:destVC animated:YES];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation


/**
 * call get banner images
 */
- (void) callGetBannerImages
{
	if (!isAliveTimer) {
		return;
	}
	
	//	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetAdverts];
}

- (void) getAdvertsResult:(NSInteger)retcode retmsg:(NSString *)retmsg adverts:(NSMutableArray *)adverts relatives:(NSMutableArray *)relatives
{
	if (retcode == SVCERR_SUCCESS) {
		
		//		[SVProgressHUD dismiss];
		if ([self isChangedBannerImages:adverts relatvies:relatives])
		{
			orgAdverts = adverts;
			orgRelatives = relatives;
			[self loadAdvertiseView];
		}
	}
	else
	{
		//		[SVProgressHUD dismissWithError:message afterDelay:DEF_DELAY];
		showToast(retmsg);
	}
}

- (BOOL) isChangedBannerImages : (NSMutableArray *)newAdverts relatvies:(NSMutableArray *)newRelatives
{
	// check length
	if (([newAdverts count] == [orgAdverts count]) && ([newRelatives count] == [orgRelatives count]))
	{
		// check content
		for (int i = 0; i < [newAdverts count]; i++) {
			NSString * newUrl = [(STAdvertImage *)[newAdverts objectAtIndex:i] image_url];
			NSString * orgUrl = [(STAdvertImage *)[orgAdverts objectAtIndex:i] image_url];
			if (![newUrl isEqualToString:orgUrl]) {
				return YES;
			}
		}
		
		for (int i = 0; i < [newRelatives count]; i++) {
			long new_id = [(STRelative *)[newRelatives objectAtIndex:i] uid];
			long org_id = [(STRelative *)[orgRelatives objectAtIndex:i] uid];
			if (new_id != org_id) {
				return YES;
			}
		}
		
	}
	else
	{
		return YES;
	}
	
	return NO;
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueToYuanGongYeJi"])
	{
		LingDaoYeJiVC *vc = segue.destinationViewController;

		vc.isEmployee = TRUE;
	}else if ([segue.identifier isEqualToString:@"segueToDaiXiaoYeJi"])
	{
		LingDaoYeJiVC *vc = segue.destinationViewController;
		vc.isEmployee = FALSE;

	}
}

@end
