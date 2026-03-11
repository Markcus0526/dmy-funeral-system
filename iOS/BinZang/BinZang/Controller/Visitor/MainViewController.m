//
//  MainViewController.m
//  FSSystem
//
//  Created by Kim Ok Chol on 1/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MainViewController.h"
#import "Config.h"
#import "APService.h"
#import "SanLiuDetailVC.h"
#import "BinZangZhiShiMainVC.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"
//#import "CLLocation+Strings.h"


MainViewController *shareMainView;

@interface MainViewController ()<BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>
{
	UIViewController *				partnerVC;
	SGFocusImageFrame *             _bannerView;
	NSMutableArray *	            bannerImages;
	NSMutableArray *				orgBannerImgs;
	
	NSTimer *						mTimerBanner;
	BOOL							isAliveTimer;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@end


#define CHKBANNER_TIME_DELAY				60
#define SEGUE_TO_BINZANGNEWS				@"segueFromMainToBinZangNews"
#define SEGUE_TO_BINZANGSERVICE				@"segueFromMainToBinZangService"
#define SEGUE_TO_BINZANGKNOLEDGE			@"segueFromMainToBinZangKnoledge"

#define SANLIU_VC_ID						@"vc36Detail"
#define SWIPE_VC_ID							@"vcVstMain"


@implementation MainViewController

{
    CLLocationManager *locationManager;
    
    BMKLocationService *                locService;
}

@synthesize mDesPos;
@synthesize mCurPos;
//@synthesize  locationManager;
@synthesize currentLocation;
@synthesize mbStartNavi;

- (IBAction)OnClickDaoHang:(id)sender {
    
    mbStartNavi = false;
    [self startNavi];
}

+(id) shareInstance
{
	if (!shareMainView)
	{
		shareMainView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:SWIPE_VC_ID];
	}
	return shareMainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
    locationManager = [[CLLocationManager alloc] init];
    
	[self initControls];
    
    mbStartNavi = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
	if ([segue.identifier isEqualToString:SEGUE_TO_BINZANGKNOLEDGE]) {
		BinZangZhiShiMainVC *destCtrl = (BinZangZhiShiMainVC *)segue.destinationViewController;
		// show second tab
		[destCtrl setNState:0];
	}
	else if ([segue.identifier isEqualToString:SEGUE_TO_BINZANGNEWS]) {
        BinZangZhiShiMainVC *destCtrl = (BinZangZhiShiMainVC *)segue.destinationViewController;
		// show second tab
		[destCtrl setNState:1];
    }
	else if ([segue.identifier isEqualToString:SEGUE_TO_BINZANGSERVICE]) {
		BinZangZhiShiMainVC *destCtrl = (BinZangZhiShiMainVC *)segue.destinationViewController;
		// show second tab
		[destCtrl setNState:2];
	}
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

-(void) setPartnerViewController:(UIViewController*)viewController
{
	partnerVC = viewController;
	self.navigationItem.title = viewController.navigationItem.title;
}
/**
 * Initilaize all ui controls & member variable
 */
- (void) initControls
{
	if ([Common userInfo] == nil) {
		self.navigationItem.leftBarButtonItem = nil;
	}
	
	// set swipe next view controller : CustomerMainViewController
	if (partnerVC)
		[self setNextViewController:partnerVC];
	
	if ([Common userInfo])
	{
		UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_switch_sel"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(pushNextViewController:)];
	
		UIButton *btnMark = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
		[btnMark setBackgroundImage:[UIImage imageNamed:@"icon_title"] forState:UIControlStateNormal];
	
		UIBarButtonItem *btnBack1 = [[UIBarButtonItem alloc] initWithCustomView:btnMark];
	
		self.navigationItem.leftBarButtonItems = @[btnBack, btnBack1];
	}
	else{
		self.navigationItem.title = @"亲爱客户，您好！";
		
		UIButton *btnMark = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
		UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:btnMark];
		
		UIButton *btnMark1 = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, 38, 38)];
		[btnMark1 setBackgroundImage:[UIImage imageNamed:@"icon_title"] forState:UIControlStateNormal];
		
		UIBarButtonItem *btnBack1 = [[UIBarButtonItem alloc] initWithCustomView:btnMark1];
		
		self.navigationItem.leftBarButtonItems = @[btnBack, btnBack1];
	}
	
	for (UIButton *btn in _buttons)
 	{
		borderWidthColor(btn, 1, [UIColor colorWithRed:1 green:1 blue:153.f/255 alpha:1]);
	}
    
    [self CurrentLocationIdentifier];
    [self callGetNavDestination];
}


- (void) loadAdvertiseView
{
	if (orgBannerImgs.count < 1)
		return;
	
	bannerImages = [[NSMutableArray alloc] init];
	if (orgBannerImgs.count > 0)
	{
		STBannerImg *aBanner = [orgBannerImgs objectAtIndex:orgBannerImgs.count - 1];
		[bannerImages addObject:aBanner.image_url];
	}
	for (int i = 0; i < orgBannerImgs.count - 1; i++)
	{
		STBannerImg *aBanner = [orgBannerImgs objectAtIndex:i];
		[bannerImages addObject:aBanner.image_url];
	}
	
	//    imageIndex = 0;
	NSInteger length = [bannerImages count];
	//    imageCount = length;
	NSMutableArray *tempArray = [NSMutableArray array];
	for (int i = 0 ; i < length; i++)
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"title%d",i],@"title" ,nil];
		[tempArray addObject:dict];
	}
	
	NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
	
	if (length > 1)
	{
		NSDictionary *dict = [tempArray objectAtIndex:length-1];
		SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1];
		[itemArray addObject:item];
	}
	for (int i = 0; i < length; i++)
	{
		NSDictionary *dict = [tempArray objectAtIndex:i];
		SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i];
		[itemArray addObject:item];
		
	}
	//添加第一张图 用于循环
	if (length >1)
	{
		NSDictionary *dict = [tempArray objectAtIndex:0];
		SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1];
		[itemArray addObject:item];
	}
	
	
	UIImage * defImage = DEF_IMAGE;
	
	_bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, _vwSliderContainer.frame.size.width, _vwSliderContainer.frame.size.height) delegate:self imageItems:itemArray isAuto:YES array:bannerImages isOnline:YES defImage:defImage];
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
	
	STBannerImg * bannerInfo = (STBannerImg *)[orgBannerImgs objectAtIndex:item.tag];
	// go to 36view
	SanLiuDetailVC * destVC = [self.storyboard instantiateViewControllerWithIdentifier:SANLIU_VC_ID];
	ST36View * info = [[ST36View alloc] init];
	info.uid = bannerInfo.uid;
	destVC.mViewInfo = info;
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
	[[[CommManager getCommMgr] comSvcMgr] GetBannerImages];
}

- (void) getBannerImagesResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS) {
		
//		[SVProgressHUD dismiss];
		if ([self isChangedBannerImages:datalist])
		{
			orgBannerImgs = datalist;
			
			[self loadAdvertiseView];
		}
	}
	else
	{
//		[SVProgressHUD dismissWithError:message afterDelay:DEF_DELAY];
		showToast(retmsg);
	}
}

- (BOOL) isChangedBannerImages : (NSMutableArray *)newArray
{
	// check length
	if ([newArray count] == [orgBannerImgs count])
	{
		// check content
		for (int i = 0; i < [newArray count]; i++) {
			NSString * newUrl = [(STBannerImg *)[newArray objectAtIndex:i] image_url];
			NSString * orgUrl = [(STBannerImg *)[orgBannerImgs objectAtIndex:i] image_url];
			if (![newUrl isEqualToString:orgUrl]) {
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

// for daohang
- (void) CurrentLocationIdentifier
{
    //if ( locationManager == nil )
    {
        locService = [[BMKLocationService alloc] init];
        locService.delegate = self;
        
        [locationManager setDelegate:self];
        
       // locationManager.desiredAccuracy = [setupInfo[kSetupInfoKeyAccuracy] doubleValue];
        
        locationManager.distanceFilter = 10.0f;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        
        [locService startUserLocationService];
        //[locationManager startUpdatingLocation];
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    MyLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    // set updated user location
    CLLocation * newLocation = userLocation.location;
    
    if ( mCurPos == nil )
        mCurPos = [[STGpsPos alloc] init];
    
    mCurPos.lng = newLocation.coordinate.longitude;
    mCurPos.lat = newLocation.coordinate.latitude;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        if ( mCurPos == nil )
            mCurPos = [[STGpsPos alloc] init];
        
        mCurPos.lng = currentLocation.coordinate.longitude;
        mCurPos.lat = currentLocation.coordinate.latitude;
        
        MyLog(@"long %.8f", currentLocation.coordinate.longitude);
        MyLog(@"lat %.8f", currentLocation.coordinate.latitude);
        
        //[self startNavi];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    /*
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
     */
}

- (void) callGetNavDestination
{
    //[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetNavDestination];
}

- (void) getNavDestination : (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STGpsPos*) datainfo
{
    if (retcode == SVCERR_SUCCESS)
    {
        //[SVProgressHUD dismiss];
        
        mDesPos = datainfo;
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}

- (void)startNavi
{
    //if ( mbStartNavi )
     //   return;
    
    if ( mCurPos == nil || mCurPos.lat == 0 || mCurPos.lng == 0 || mDesPos == nil || mDesPos.lng == 0 || mDesPos.lat == 0 )
        return;
    
    mbStartNavi = true;
    
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = mCurPos.lng;
    startNode.pos.y = mCurPos.lat;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = mDesPos.lng;
    endNode.pos.y = mDesPos.lat;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Highway naviNodes:nodesArray time:nil delegete:self userInfo:nil];
   }

#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        NSLog(@"定位服务未开启");
    }
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

#pragma mark - BNNaviUIManagerDelegate

//退出导航回调
-(void)onExitNaviUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航");
}

//退出导航声明页面回调
- (void)onExitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
}

-(void)onExitDigitDogUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出电子狗页面");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
