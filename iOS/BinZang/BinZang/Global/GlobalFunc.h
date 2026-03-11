//
//  Common.h
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "STDataInfo.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <AdSupport/AdSupport.h>
#import "MACAddress.h"


typedef NS_ENUM(NSInteger, DEVICE_KIND) {
    IPHONE4= 1,
    IPHONE5,
    IPAD,
};

@interface GlobalFunc : NSObject {
}

+ (BOOL) isOverIOS8;
+ (BOOL) isOverIOS7;
+ (float)getSystemVersion;

+ (void) makeErrorWindow : (NSString *)content TopOffset:(NSInteger)topOffset BottomOffset:(NSInteger)bottomOffset View:(UIView *)view;

+ (BOOL) hasNetworkConnectivity;


+ (NSString *) getCurTime : (NSString*)fmt;
+ (NSString *) convertDateToString : (NSDate *)date fmt:(NSString *)fmt;
+ (NSString *) convertODateToString : (NSDate *)date fmt:(NSString *)fmt;
+ (NSDate *) convertStringToDate : (NSString *)date fmt:(NSString *)fmt;
+ (NSDateComponents *) convertNSDateToNSDateComponents : (NSDate *)date;
+ (NSDate *) convertNSDateComponentsToNSDate : (NSDateComponents *)components;

+ (NSInteger) phoneType;

+ (NSString*) base64forData:(NSData*)theData;
+ (NSData*) base64forString:(NSString*)theString;

+ (NSString *) appNameAndVersionNumberDisplayString;

+ (NSString *) md5:(NSString *) input;

+ (NSString*)getAdvertiseIdentifier;
+ (NSString*)getDeviceIDForVendor;
+ (NSString*)getDeviceMacAddress;       // used for IMEI

+ (void)callPhone : (NSString *)phoneNum;


+ (int)getIntValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (long)getLongValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (NSString*)getStringValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (double)getDoubleValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (float)getFloatValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)getScaledImage:(UIImage *)image insideButton:(UIButton *)button;

@end
