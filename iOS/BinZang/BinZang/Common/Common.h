//
//  Common.h
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface Common : NSObject {
}

typedef enum{
	UserType_NONE,
	UserType_DongShiZhang,
	UserType_ZongJingLi,
	UserType_FuZongJingLi,
	UserType_ZhuRen,
	UserType_FuZhuRen,
	UserType_YuanGong,
	UserType_DaiXiaoShang,
	UserType_JiuKeHu,
}STUserType;

+ (void) setDeviceToken : (NSString*)newDeviceToken;
+ (NSString*) deviceToken;

+ (void) setUserInfo : (STUserInfo*)userInfo;
+ (STUserInfo*) userInfo;
+ (NSString *) strUserId;
+ (NSString *) strUserType;

+ (void) setCurrentPos : (double)lat lng:(double)lng;
+ (double) getCurrentPosLat;
+ (double) getCurrentPosLng;

+ (void) setCurrentCity : (NSString *)curCity;
+ (NSString *) getCurrentCity;

+ (void) setCurrentAddr : (NSString *)curAddr;
+ (NSString *) getCurrentAddr;

+ (NSString *) getBaiduServiceKey;

+ (NSString *) createCheckSum : (NSString *)method_name;

+ (UIColor *) getAppColor;

+ (BOOL) IsNullOrEmptyString: (NSString*)str;
@end
