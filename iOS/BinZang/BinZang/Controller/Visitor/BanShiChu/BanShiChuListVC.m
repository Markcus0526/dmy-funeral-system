//
//  BanShiChuListVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BanShiChuListVC.h"
#import "BanShiChuDetailVC.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"

@interface OfficeTableCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;

@property (weak, nonatomic) IBOutlet UILabel *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@property (nonatomic, retain) BanShiChuListVC *parentVC;
@end

@implementation OfficeTableCell
{
	NSInteger tag;
	STOfficeCityItem *officeItem;
}

-(void) setValue : (STOfficeCityItem*)datainfo : (NSInteger) nTag
{
	officeItem = datainfo;
	tag = nTag;
	
	
    [_lblTitle setText:officeItem.name];
    [_imgMain setImageWithURL:[NSURL URLWithUnicodeString:officeItem.image_url] placeholderImage:DEF_IMAGE];
	
    //borderWidthColor(_imgMain, 0.5, [UIColor grayColor]);
    //[_txtAddress setText:datainfo.address];
    [_lblPhone setText:officeItem.phone];
	
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:datainfo.phone];
    
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
	
	_lblPhone.userInteractionEnabled = YES;
    _lblPhone.attributedText = [attributeString copy];
	UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCallPhone)];
	[_lblPhone addGestureRecognizer:tapGesture1];
	
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:datainfo.address];
    
    [attributeString2 addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString2 length]}];
	
	_txtAddress.userInteractionEnabled = YES;
	_txtAddress.attributedText = [attributeString2 copy];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDaoFang)];
	[_txtAddress addGestureRecognizer:tapGesture];

}

- (void) tapDaoFang
{
	[_parentVC gotoDaoFanAddress:tag];
}

- (void) tapCallPhone
{
	
	[GlobalFunc callPhone:officeItem.phone];
	
	return;
}
@end

@interface BanShiChuListVC ()
{
	//NSMutableArray *			arrOffices;
    STGpsPos *		mCurPos;
    int     nSelectItem;
    
    BMKLocationService *                locService;
}
@property (weak, nonatomic) IBOutlet UITableView *tblOffice;
@end


#define CELL_ID					@"cellOfficeIntro"
#define CELL_HEIGHT				150
#define SEGUE_TO_DETAIL			@"segueToDetail"


@implementation BanShiChuListVC
{
    CLLocationManager *locationManager;
}

@synthesize mOfficesInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
	{
		// get current office data
		STOfficeCityItem * datainfo = (STOfficeCityItem *)sender;
        
		// set data
		BanShiChuDetailVC * destCtrl = (BanShiChuDetailVC *)segue.destinationViewController;
		destCtrl.mOfficeUid = datainfo.uid;
	}
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	//[self callGetOfficelist];
    [_tblOffice reloadData];
    mCurPos = nil;
    locationManager = [[CLLocationManager alloc] init];
    
    [self CurrentLocationIdentifier];
}

// for daohang
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

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    /*
     NSLog(@"didFailWithError: %@", error);
     UIAlertView *errorAlert = [[UIAlertView alloc]
     initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [errorAlert show];
     */
}


/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems
{
	//arrOffices = arrItems;
	[_tblOffice reloadData];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if (mOfficesInfo == nil) {
		return 0;
	}
	
	return mOfficesInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	OfficeTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[OfficeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	STOfficeCityItem * datainfo = (STOfficeCityItem *)[mOfficesInfo objectAtIndex:indexPath.row];
    [cell setValue:datainfo :indexPath.row ];
	cell.parentVC = self;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	STOfficeCityItem * office = [mOfficesInfo objectAtIndex:indexPath.row];
	
	[self performSegueWithIdentifier:SEGUE_TO_DETAIL sender:office];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1)
	{
        STOfficeCityItem * datainfo = (STOfficeCityItem *)[mOfficesInfo objectAtIndex:alertView.tag];
        
        if ( nSelectItem == 1 )
        {
            [GlobalFunc callPhone:datainfo.phone];
        }
		//STOffice * datainfo = (STOffice *)[arrOffices objectAtIndex:alertView.tag];
		// go to address navigation
        else{
            
            if ( mCurPos == nil || datainfo == nil )
                return;
            
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
            endNode.pos.x = datainfo.lng;
            endNode.pos.y = datainfo.lat;
            endNode.pos.eType = BNCoordinate_BaiduMapSDK;
            [nodesArray addObject:endNode];
            
            [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Highway naviNodes:nodesArray time:nil delegete:self userInfo:nil];
        }

	}
	
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction Relation

- (void) gotoDaoFanAddress:(NSInteger)tag
{
    if ( mCurPos == nil )
        return;
    
    nSelectItem = 0;
	// show alert view
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_GOTO_OFFICE delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
	[alert setTag:tag];
	[alert show];
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
