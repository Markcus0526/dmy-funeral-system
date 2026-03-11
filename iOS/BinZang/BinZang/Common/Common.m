//
//  Common.m
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import "Common.h"

// Common variables

NSString *      _deviceToken = @"";
STUserInfo *    _userInfo = nil;
NSString *      _curCity = @"沈阳";
NSString *      _curAddr = @"";

double          _curPosLat = 0;
double          _curPosLng = 0;


@implementation Common

+ (void) setDeviceToken : (NSString*)newDeviceToken
{
    _deviceToken = newDeviceToken;
}

+ (NSString*) deviceToken
{
    return _deviceToken;
}

+ (void) setUserInfo : (STUserInfo*)userInfo;
{
    _userInfo = userInfo;
}

+ (STUserInfo*) userInfo
{
    return _userInfo;
}

+ (NSString *) strUserId
{
	if (_userInfo == nil) {
		return @"";
	}
	
	return [NSString stringWithFormat:@"%ld", _userInfo.uid];
}

+ (NSString *) strUserType
{
	if (_userInfo == nil) {
		return @"";
	}
	
	return [NSString stringWithFormat:@"%ld", (long)_userInfo.user_type];
}

+ (void) setCurrentPos : (double)lat lng:(double)lng
{
    _curPosLat = lat;
    _curPosLng = lng;
}

+ (double) getCurrentPosLat
{
    return _curPosLat;
}

+ (double) getCurrentPosLng
{
    return _curPosLng;
}

+ (void) setCurrentCity : (NSString *)curCity
{
    _curCity = curCity;
}

+ (NSString *) getCurrentCity
{
    return _curCity;
}

+ (void) setCurrentAddr : (NSString *)curAddr;
{
    _curAddr = curAddr;
}

+ (NSString *) getCurrentAddr
{
    return _curAddr;
}

+ (NSString *) getBaiduServiceKey
{
	return @"p9mWsPwmgQKl4fgr5YxqhmhI";
}

+ (NSString *) createCheckSum : (NSString *)method_name
{
	NSString * check_sum = @"";
	NSString * access_token = [[self userInfo] access_token];
	
	check_sum = [GlobalFunc md5:[NSString stringWithFormat:@"%@,%@", access_token, method_name]];
	
	return check_sum;
}

+ (UIColor *) getAppColor
{
	return [UIColor colorWithRed:84.f/256.f green:174.f/256.f blue:68.f/256.f alpha:1.f];
}

+ (BOOL) IsNullOrEmptyString: (NSString*)str
{
    if ( str == nil )
        return  TRUE;
    
    NSString *trimedstr  = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( trimedstr.length == 0 )
        return TRUE;
    
    return  FALSE;
}
@end
