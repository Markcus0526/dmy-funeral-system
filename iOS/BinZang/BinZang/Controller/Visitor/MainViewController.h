//
//  MainViewController.h
//  FSSystem
//
//  Created by Kim Ok Chol on 1/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "MainSwipeViewController.h"
//#import "MobileCoreServices/MobileCoreServices.h>
#import "CoreLocation/CoreLocation.h"
#import "BMKLocationService.h"

@interface MainViewController : MainSwipeViewController <CLLocationManagerDelegate, ComSvcDelegate, SGFocusImageFrameDelegate, BMKLocationServiceDelegate>

- (IBAction)OnClickDaoHang:(id)sender;


+(id) shareInstance;
-(void) setPartnerViewController:(UIViewController*)viewController;
@property (weak, nonatomic) IBOutlet UIView * vwSliderContainer;

// for daohang
//@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;

@property (nonatomic, retain) STGpsPos *		mDesPos;
@property (nonatomic, retain) STGpsPos *		mCurPos;

@property (nonatomic, readwrite) BOOL  mbStartNavi;
@end
