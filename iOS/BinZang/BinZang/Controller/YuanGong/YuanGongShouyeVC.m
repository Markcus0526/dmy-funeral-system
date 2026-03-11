//
//  YuanGongShouyeVC.m
//  BinZang
//
//  Created by Beids on 5/6/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "YuanGongShouyeVC.h"
#import "MainViewController.h"
#import "UIView+ScreenShot.h"
#import "HuoDongDetailVC.h"
#import "DingJinDanChaXunVC_YG.h"
#import "YiShiYuYueVC.h"

#define CHKBANNER_TIME_DELAY				60

@interface YuanGongShouyeVC ()
{
	UIViewController *				partnerVC;
	
    NSMutableArray *				arrAdverts;
    NSMutableArray *				arrRelatives;
    
    NSMutableArray *				orgAdverts;
    NSMutableArray *				orgRelatives;
        
    SGFocusImageFrame *             _bannerView;
    NSMutableArray *	            bannerImages;
        
    NSTimer *						mTimerBanner;
    BOOL							isAliveTimer;
}
@end

@implementation YuanGongShouyeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    // Do any additional setup after loading the view.
	[self initControls];
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
    
    [self callGetNewActivityCount];
    [self callGetBuyProductCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Basic Function
-(void) setPartnerViewController:(UIViewController*)viewController
{
	partnerVC = viewController;
	self.navigationItem.title = viewController.navigationItem.title;
}


- (void) initControls
{
	bool isZhuRen = [Common userInfo].user_type == UserType_ZhuRen;
	if (isZhuRen)
	{
		if (partnerVC)
			[self setNextViewController:partnerVC];
	
	}else
	{
		MainViewController *mainVC = [MainViewController shareInstance];
		[mainVC setPartnerViewController:self];
		[self setNextViewController:mainVC];
	}
	
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_switch_sel"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(pushNextViewController:)];
    
    UIButton *btnMark = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
    [btnMark setBackgroundImage:[UIImage imageNamed:@"icon_title"] forState:UIControlStateNormal];
    
    UIBarButtonItem *btnBack1 = [[UIBarButtonItem alloc] initWithCustomView:btnMark];
    
    self.navigationItem.leftBarButtonItems = @[btnBack, btnBack1];
    
    for (UIButton *btn in __buttons)
    {
        borderWidthColor(btn, 1, [UIColor colorWithRed:1 green:1 blue:153.f/255 alpha:1]);
    }
    
    _lblHuoDongNotifier.hidden = YES;
    roundRect(_lblHuoDongNotifier, _lblHuoDongNotifier.frame.size.width / 2);
    
    _lblZiYouNotifier.hidden = YES;
    roundRect(_lblZiYouNotifier, _lblZiYouNotifier.frame.size.width / 2);
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
    
    //[_vwRelTemp setHidden:YES];
}


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
	if ([segue.identifier isEqualToString:@"segueDingJinDan"])
	{
		DingJinDanChaXunVC_YG *vc = segue.destinationViewController;
		
		vc.isOwnDingJinDan = YES;
	}
}

#pragma mark - User Event

- (IBAction)OnHuiDongTongZhi:(id)sender
{
    UIViewController *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HuoDongListVC"];
    
    [self.navigationController pushViewController:viewVC animated:YES];
}

//
- (IBAction)OnLingYuanYuLiu:(id)sender {
    UIViewController *viewVC = [[UIStoryboard storyboardWithName:@"DaiXiaoShang" bundle:nil] instantiateViewControllerWithIdentifier:@"SIDLigYuanYuLiu"];
    
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)OnJiangJinJiSuan:(id)sender {
    UIViewController *viewVC = [[UIStoryboard storyboardWithName:@"DaiXiaoShang" bundle:nil] instantiateViewControllerWithIdentifier:@"SIDJiangJinJiSuan"];
    
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)OnZhangDanChaXun:(id)sender {
    UIViewController *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZhangDanChaXunVC"];
    
    [self.navigationController pushViewController:viewVC animated:YES];
}


- (IBAction)OnLuoZangYiShiYuYue:(id)sender {
	YiShiYuYueVC *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YiShiYuYueVC"];
	
	viewVC.isAgent = YES;
	viewVC.need_bury_service = NO;
	[self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)OnDaiDingJiPinGouMai:(id)sender {
	YiShiYuYueVC *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YiShiYuYueVC"];
	
	viewVC.isAgent = YES;
	viewVC.need_bury_service = YES;
	[self.navigationController pushViewController:viewVC animated:YES];
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
        
        if (count > 0)
        {
            _lblHuoDongNotifier.hidden = NO;
            _lblHuoDongNotifier.text = [NSString stringWithFormat:@"%d", count];
        }else{
            _lblHuoDongNotifier.hidden = YES;
        }
    }
    else
    {
        showToast(retmsg);
    }
}

- (void) callGetBuyProductCount
{
    if (!isAliveTimer) {
        return;
    }
    
    //	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetBuyProductCount];
}

- (void) getBuyProductCountResult		: (NSInteger)retcode retmsg:(NSString *)retmsg count:(int)count;
{
    if (retcode == SVCERR_SUCCESS) {
        
        if (count > 0)
        {
            _lblZiYouNotifier.hidden = NO;
            _lblZiYouNotifier.text = [NSString stringWithFormat:@"%d", count];
        }else{
            _lblZiYouNotifier.hidden = YES;
        }
    }
    else
    {
        showToast(retmsg);
    }
}

@end
