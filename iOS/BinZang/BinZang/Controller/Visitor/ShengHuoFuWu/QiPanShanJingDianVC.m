//
//  QiPanShanJingDianVC.m
//  BinZang
//
//  Created by Beids on 5/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "QiPanShanJingDianVC.h"

#import "QiPanShanJingDianVC.h"
#import "ShengHuoJingDianDetailVC.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"
#
@implementation JingDianTableCell
-(void) setValue : (STMtQiPan*)datainfo : (NSInteger) nTag
{
    [_lblTitle setText:datainfo.title];
    [_imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
    borderWidthColor(_imgMain, 2, [UIColor grayColor]);
    [_lblPhone setText:datainfo.phone];
    [_btnAddress setTag:nTag];
    [_btnPhone setTag:nTag];
    [_btnMain setTag:nTag];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:datainfo.phone];
    
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    _lblPhone.attributedText = [attributeString copy];
    
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:datainfo.address];
    
    [attributeString2 addAttribute:NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInt:1]
                             range:(NSRange){0,[attributeString2 length]}];
    
    _txtAddress.attributedText = [attributeString2 copy];
}
@end

@interface QiPanShanJingDianVC ()
{
    NSMutableArray *			arrViews;
    STGpsPos *		mCurPos;
    int     nSelectItem;
}
@end


#define CELL_ID					@"cellOfficeIntro"
#define CELL_HEIGHT				100
#define SEGUE_TO_DETAIL			@"segueToJingDianDetail"


@implementation QiPanShanJingDianVC
{
    CLLocationManager *locationManager;
    
    BMKLocationService *                locService;
}

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
        UIButton * button = (UIButton *)sender;
        
        STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:button.tag];
        // set data
        ShengHuoJingDianDetailVC * destCtrl = (ShengHuoJingDianDetailVC *)segue.destinationViewController;
        destCtrl.mDetailInfo = datainfo;        /*
        STOfficeCityItem * datainfo = (STOfficeCityItem *)[mOfficesInfo objectAtIndex:button.tag];
        
        // set data
        BanShiChuDetailVC * destCtrl = (BanShiChuDetailVC *)segue.destinationViewController;
        destCtrl.mOfficeUid = datainfo.uid;*/
    }
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
    //[self callGetOfficelist];
    //[_tblOffice reloadData];
    mCurPos = nil;
    
    locationManager = [[CLLocationManager alloc] init];
    
    [self callGetJingDianlist];
    
    [self CurrentLocationIdentifier];
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

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems
{
    arrViews = arrItems;
    //arrOffices = arrItems;
    [_tblOffice reloadData];
}

- (void) callGetJingDianlist
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetMtQiPanViews];
}

- (void) getMtQiPanViewsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
    if (retcode == SVCERR_SUCCESS)
    {
        [SVProgressHUD dismiss];
        
        [self updateUI:datalist];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (arrViews == nil) {
        return 0;
    }
    
    return arrViews.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* szID = CELL_ID;
    JingDianTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    if (cell == nil)
    {
        cell = [[JingDianTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
    }
    
    STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:indexPath.row];
    [cell setValue:datainfo :indexPath.row ];
    
    return cell;
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:alertView.tag];
        
        if ( nSelectItem == 1 )
        {
            
        }
        //STOffice * datainfo = (STOffice *)[arrOffices objectAtIndex:alertView.tag];
        // go to address navigation
        else{
            
            if ( mCurPos == nil )
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

- (IBAction)onTapAddress:(id)sender
{
    if ( mCurPos == nil )
        return;
    
    UIButton * button = (UIButton *)sender;
    
    nSelectItem = 0;
    // show alert view
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_GOTO_ADDRESS delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
    [alert setTag:button.tag];
    [alert show];
}

- (IBAction)onTapPhone:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    //STOffice * datainfo = (STOffice *)[arrOffices objectAtIndex:button.tag];
    STMtQiPan * datainfo = (STMtQiPan *)[arrViews objectAtIndex:button.tag];
    
    [GlobalFunc callPhone:datainfo.phone];
    return;
    
    nSelectItem = 1;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:[NSString stringWithFormat:MSG_GOTO_PHONE, datainfo.phone] delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
    [alert setTag:button.tag];
    [alert show];
    //[GlobalFunc callPhone:datainfo.phone];
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
