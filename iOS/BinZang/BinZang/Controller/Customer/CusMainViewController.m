//
//  CusMainViewController.m
//  BinZang
//
//  Created by KimOkChol on 4/22/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "CusMainViewController.h"
#import "UIView+ScreenShot.h"
#import "MainViewController.h"
#import "HuoDongDetailVC.h"
#import "YiShiYuYueVC.h"

@interface CusMainViewController ()
{
	NSMutableArray *				arrAdverts;
	NSMutableArray *				arrRelatives;
	
	NSMutableArray *				orgAdverts;
	NSMutableArray *				orgRelatives;
	
	SGFocusImageFrame *             _bannerView;
	NSMutableArray *	            bannerImages;
	
	NSTimer *						mTimerBanner;
	BOOL							isAliveTimer;
	
	NSMutableArray *				arrParentInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *lblNotif;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *btnParentOK;
@property (weak, nonatomic) IBOutlet UIView *vwParentInfo;
@property (weak, nonatomic) IBOutlet UIView *vwParentContent;
@property (weak, nonatomic) IBOutlet UILabel *lblParentInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblParentDate;
@property (weak, nonatomic) IBOutlet UILabel *lblParentTomb;

@end


#define CHKBANNER_TIME_DELAY				60

@implementation CusMainViewController

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
	
	[self callCheckParentBirthNotify];
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
	
	roundRect(_lblNotif, _lblNotif.frame.size.width / 2);
	_lblNotif.hidden = YES;

	UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_switch_sel"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(pushNextViewController:)];
		
	UIButton *btnMark = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
	[btnMark setBackgroundImage:[UIImage imageNamed:@"icon_title"] forState:UIControlStateNormal];
		
	UIBarButtonItem *btnBack1 = [[UIBarButtonItem alloc] initWithCustomView:btnMark];

	self.navigationItem.leftBarButtonItems = @[btnBack, btnBack1];
	
	for (UIButton *btn in _buttons)
	{
		borderWidthColor(btn, 1, [UIColor colorWithRed:1 green:1 blue:153.f/255 alpha:1]);
	}
	
	roundRect(_vwParentContent, DEF_CORNER_RADIO);
	roundRect(_btnParentOK, DEF_CORNER_RADIO);
	_vwParentInfo.hidden = YES;
}


- (void) loadAdvertiseView
{
	// check banner count
	if ((orgAdverts.count + orgRelatives.count) < 1)
		return;
	
	// banner image data list
	bannerImages = [[NSMutableArray alloc] init];
	NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:(orgAdverts.count + orgRelatives.count + 2)];
	
	// check adverts
	if (orgAdverts.count > 0 && orgRelatives.count < 1)
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
	else if (orgAdverts.count < 1 && orgRelatives.count > 0)
	{
		// add one for chain
		STRelative *aBanner = [orgRelatives objectAtIndex:orgRelatives.count - 1];
		// make set view & make uiimage
		[_lblTmpRelative setText:[NSString stringWithFormat:@"%@ : %@", aBanner.relative, aBanner.name]];
		[_lblTmpArea setText:aBanner.area_no];
		[_lblTmpBirthday setText:aBanner.birthday];
		[_lblTmpDeathday setText:aBanner.deathday];
		UIImage * tmpImage = [_vwRelTemp convertViewToImage];
		
		[bannerImages addObject:tmpImage];
		
		// make item data
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSString stringWithFormat:@"title%d", -1], @"title",
							  @"1", @"type",
							  nil];
		SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1];
		[itemArray addObject:item];
		
		for (int i = 0; i < orgRelatives.count - 1; i++)
		{
			STRelative *aBanner = [orgRelatives objectAtIndex:i];
			// make set view & make uiimage
			[_lblTmpRelative setText:[NSString stringWithFormat:@"%@ : %@", aBanner.relative, aBanner.name]];
			[_lblTmpArea setText:aBanner.area_no];
			[_lblTmpBirthday setText:aBanner.birthday];
			[_lblTmpDeathday setText:aBanner.deathday];
			UIImage * tmpImage = [_vwRelTemp convertViewToImage];
			
			[bannerImages addObject:tmpImage];
			
			// make item data
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSString stringWithFormat:@"title%d", i], @"title",
								  @"1", @"type",
								  nil];
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i];
			[itemArray addObject:item];
		}
		
		NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSString stringWithFormat:@"title%lu", orgAdverts.count - 1], @"title",
							   @"1", @"type",
							   nil];
		SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithDict:dict1 tag:orgAdverts.count-1];
		[itemArray addObject:item1];
		NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"title0", @"title",
							   @"1", @"type",
							   nil];
		SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithDict:dict2 tag:-1];
		[itemArray addObject:item2];
	}
	else
	{
		// add one for chain
		STRelative *aBanner = [orgRelatives objectAtIndex:orgRelatives.count - 1];
		// make set view & make uiimage
		[_lblTmpRelative setText:[NSString stringWithFormat:@"%@ : %@", aBanner.relative, aBanner.name]];
		[_lblTmpArea setText:aBanner.area_no];
		[_lblTmpBirthday setText:aBanner.birthday];
		[_lblTmpDeathday setText:aBanner.deathday];
		UIImage * tmpImage = [_vwRelTemp convertViewToImage];
		
		[bannerImages addObject:tmpImage];
		
		
		// make item data
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSString stringWithFormat:@"title%d", -1], @"title",
							  @"1", @"type",
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
		for (int i = 0; i < orgRelatives.count - 1; i++)
		{
			STRelative *aBanner = [orgRelatives objectAtIndex:i];
			// make set view & make uiimage
			[_lblTmpRelative setText:[NSString stringWithFormat:@"%@ : %@", aBanner.relative, aBanner.name]];
			[_lblTmpArea setText:aBanner.area_no];
			[_lblTmpBirthday setText:aBanner.birthday];
			[_lblTmpDeathday setText:aBanner.deathday];
			UIImage * tmpImage = [_vwRelTemp convertViewToImage];
			
			[bannerImages addObject:tmpImage];
			
			// make item data
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSString stringWithFormat:@"title%d", i], @"title",
								  @"1", @"type",
								  nil];
			SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i];
			[itemArray addObject:item];
		}
		
		NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSString stringWithFormat:@"title%lu", orgAdverts.count + orgRelatives.count - 1], @"title",
							   @"1", @"type",
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
	
	[_vwRelTemp setHidden:YES];
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

- (void) callGetNewActivityCount
{
	if (!isAliveTimer) {
		return;
	}
	
	//	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetNewActCount];
}

- (void) getNewActCountResult		: (NSInteger)retcode retmsg:(NSString *)retmsg count:(int)count;
{
	if (retcode == SVCERR_SUCCESS) {
		
		//		[SVProgressHUD dismiss];
		if (count > 0)
		{
			_lblNotif.hidden = NO;
			_lblNotif.text = [NSString stringWithFormat:@"%d", count];
		}else{
			_lblNotif.hidden = YES;
		}
	}
	else
	{
		//		[SVProgressHUD dismissWithError:message afterDelay:DEF_DELAY];
		showToast(retmsg);
	}
}

- (void) callCheckParentBirthNotify
{
	if (!isAliveTimer) {
		return;
	}
	
	//	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] checkParentBirthNotify:[Common userInfo].uid];
}
- (void) checkParentBirthNotifyResult : (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS) {
		
		//[SVProgressHUD dismiss];
		arrParentInfo = datalist;
		[self onParentOK:nil];
		[self callGetNewActivityCount];
	}
	else
	{
		//[SVProgressHUD dismissWithError:message afterDelay:DEF_DELAY];
		showToast(retmsg);
	}
}

//////
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

- (IBAction)onYiShiYuYue:(id)sender
{
	YiShiYuYueVC *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YiShiYuYueVC"];
	
	viewVC.isAgent = NO;
	viewVC.need_bury_service = NO;
	[self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)onJiBaiYuYue:(id)sender
{
	YiShiYuYueVC *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YiShiYuYueVC"];
	
	viewVC.isAgent = NO;
	viewVC.need_bury_service = YES;
	[self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)onParentOK:(id)sender
{
	if (arrParentInfo.count <= 0)
		_vwParentInfo.hidden = YES;
	else{
		STParentBirthNotify *info = [arrParentInfo objectAtIndex:0];
		[arrParentInfo removeObject:info];
		
		_vwParentInfo.hidden = NO;
		_lblParentInfo.text = info.desc;
		_lblParentTomb.text = info.tomb_no;
		_lblParentDate.text = info.date;
	}
}

//- (void)

@end
