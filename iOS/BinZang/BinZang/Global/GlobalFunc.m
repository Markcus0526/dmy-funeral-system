//
//  Common.m
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import "GlobalFunc.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

// Common variables


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation GlobalFunc

+ (BOOL) isOverIOS7
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // code here
        return true;
    }
    
    return false;
}

+ (BOOL) isOverIOS8
{
	if ([self getSystemVersion] >= 8) {
		// code here
		return true;
	}
	
	return false;
}


+ (float)getSystemVersion
{
	return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void) makeErrorWindow : (NSString *)content TopOffset:(NSInteger)topOffset BottomOffset:(NSInteger)bottomOffset View:(UIView *)view
{
    CGRect rt = [view frame];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0., topOffset, rt.size.width, rt.size.height - topOffset - bottomOffset)];
    [imgView setImage:[UIImage imageNamed:@"bkError.png"]];

	UILabel * lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0., topOffset, rt.size.width, rt.size.height - topOffset - bottomOffset)];
    lblContent.backgroundColor = [UIColor clearColor];
    lblContent.textAlignment = NSTextAlignmentCenter;
    lblContent.text = content;

	[view addSubview:imgView];
    [view addSubview:lblContent];
}


/*
 Connectivity testing code pulled from Apple's Reachability Example :http://developer.apple.com/library/ios/#samplecode/Reachability
 */
+ (BOOL) hasNetworkConnectivity
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
	if(reachability != NULL) {
		//NetworkStatus retVal = NotReachable;
		SCNetworkReachabilityFlags flags;
		if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
			if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
			{
				// if target host is not reachable
				return NO;
			}
			
			if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
			{
				// if target host is reachable and no connection is required
				//  then we'll assume (for now) that your on Wi-Fi
				return YES;
			}
			
			
			if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
				 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
			{
				// ... and the connection is on-demand (or on-traffic) if the
				//     calling application is using the CFSocketStream or higher APIs
				
				if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
				{
					// ... and no [user] intervention is needed
					return YES;
				}
			}
			
			if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
			{
				// ... but WWAN connections are OK if the calling application
				//     is using the CFNetwork (CFSocketStream?) APIs.
				return YES;
			}
		}
	}
	
	return NO;
}

+ (NSString*) getCurTime : (NSString*)fmt
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
    if ( fmt == nil ) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:fmt];
    }
	
    return [dateFormatter stringFromDate:currentDate];
}

+ (NSString *) convertODateToString : (NSDate *)date fmt:(NSString *)fmt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ( fmt == nil ) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:fmt];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) convertDateToString : (NSDate *)date fmt:(NSString *)fmt
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	if ( fmt == nil ) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	} else {
		[dateFormatter setDateFormat:fmt];
	}
	
	return [dateFormatter stringFromDate:date];
}

+ (NSDate *) convertStringToDate : (NSString *)date fmt:(NSString *)fmt
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	if ( fmt == nil ) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	} else {
		[dateFormatter setDateFormat:fmt];
	}
	
	return [dateFormatter dateFromString:date];
}

+ (NSDateComponents *) convertNSDateToNSDateComponents : (NSDate *)date
{
	NSCalendar * calendar = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;
	NSDateComponents * comps = [calendar components:unitFlags fromDate:date];
	
	return comps;
}

+ (NSDate *) convertNSDateComponentsToNSDate : (NSDateComponents *)components
{
	NSCalendar * calendar = [NSCalendar currentCalendar];
	NSDate * date = [calendar dateFromComponents:components];
	
	return date;
}

+ (NSInteger)phoneType
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == 568) {
            return IPHONE5;
        }
        else {
            return IPHONE4;
        }
    }
    else {
        return IPAD;
    }
}

+ (NSString*)base64forData:(NSData*)theData
{
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F]  :'=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F]  :'=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSData*)base64forString:(NSString*)theString
{
    NSMutableData *mutableData = nil;

    if (theString) {
		unsigned long ixtext = 0;
		unsigned long lentext = 0;
		unsigned char ch = 0;
		unsigned char inbuf[4], outbuf[3];
		short i = 0, ixinbuf = 0;
		BOOL flignore = NO;
		BOOL flendtext = NO;
		NSData *base64Data = nil;
		const unsigned char *base64Bytes = nil;
        
		// Convert the string to ASCII data.
		base64Data = [theString dataUsingEncoding:NSASCIIStringEncoding];
		base64Bytes = [base64Data bytes];
		mutableData = [NSMutableData dataWithCapacity:[base64Data length]];
		lentext = [base64Data length];
        
		while( YES ) {
			if( ixtext >= lentext ) break;
			ch = base64Bytes[ixtext++];
			flignore = NO;
            
			if( ( ch >= 'A' ) && ( ch <= 'Z' ) ) ch = ch - 'A';
			else if( ( ch >= 'a' ) && ( ch <= 'z' ) ) ch = ch - 'a' + 26;
			else if( ( ch >= '0' ) && ( ch <= '9' ) ) ch = ch - '0' + 52;
			else if( ch == '+' ) ch = 62;
			else if( ch == '=' ) flendtext = YES;
			else if( ch == '/' ) ch = 63;
			else flignore = YES;
            
			if( ! flignore ) {
				short ctcharsinbuf = 3;
				BOOL flbreak = NO;
                
				if( flendtext ) {
					if( ! ixinbuf ) break;
					if( ( ixinbuf == 1 ) || ( ixinbuf == 2 ) ) ctcharsinbuf = 1;
					else ctcharsinbuf = 2;
					ixinbuf = 3;
					flbreak = YES;
				}
                
				inbuf [ixinbuf++] = ch;
                
				if( ixinbuf == 4 ) {
					ixinbuf = 0;
					outbuf [0] = ( inbuf[0] << 2 ) | ( ( inbuf[1] & 0x30) >> 4 );
					outbuf [1] = ( ( inbuf[1] & 0x0F ) << 4 ) | ( ( inbuf[2] & 0x3C ) >> 2 );
					outbuf [2] = ( ( inbuf[2] & 0x03 ) << 6 ) | ( inbuf[3] & 0x3F );
                    
					for( i = 0; i < ctcharsinbuf; i++ )
						[mutableData appendBytes:&outbuf[i] length:1];
				}
                
				if( flbreak )  break;
			}
		}
	}
    
	return mutableData;
}


+ (NSString *)appNameAndVersionNumberDisplayString 
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return majorVersion;
}

+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


+ (NSString*)getAdvertiseIdentifier
{
    
	NSUUID* uuid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
	if (uuid == nil)
		return @"";
    
	return [uuid UUIDString];
}

+ (NSString*)getDeviceIDForVendor
{
	return [[UIDevice currentDevice].identifierForVendor UUIDString];
}


+ (NSString*)getDeviceMacAddress 
{
	if ([GlobalFunc getSystemVersion] >= 7)
		return [GlobalFunc getAdvertiseIdentifier];
	else
		return [[UIDevice currentDevice] MACAddress];
}

+ (void)callPhone : (NSString *)phoneNum;
{
    // call this phone number
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNum]]];
}



+ (int)getIntValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	long value = [GlobalFunc getLongValueWithKey:key Dict:dict];
	return (int)value;
}

+ (long)getLongValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;
	
	return (long)[objValue longLongValue];
}

+ (NSString*)getStringValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return @"";
	
	return (NSString*)objValue;
}

+ (double)getDoubleValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;
	
	return [objValue doubleValue];
}

+ (float)getFloatValueWithKey:(NSString*)key Dict:(NSDictionary*)dict
{
	id objValue = [dict objectForKey:key];
	if (objValue == nil)
		return 0;
	
	return [objValue floatValue];
}



+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
	//UIGraphicsBeginImageContext(newSize);
	// In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
	// Pass 1.0 to force exact pixel size.
	UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return newImage;
}

+ (UIImage *)getScaledImage:(UIImage *)image insideButton:(UIButton *)button
{
	// calculate the scale factor
	CGFloat imgRatio = image.size.width / image.size.height,
			btnRatio = button.frame.size.width / button.frame.size.height,
			scaleFactor = (imgRatio > btnRatio) ? image.size.width / button.frame.size.width : image.size.height / button.frame.size.height;
	
	UIImage * scaledImg = [UIImage imageWithCGImage:[image CGImage] scale:scaleFactor orientation:UIImageOrientationUp];
	
	return scaledImg;
}


@end
