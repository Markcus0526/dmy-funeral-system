//
//  Common.m
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import "Config.h"

#define KEY_LOGIN_NAME              @"loginName"
#define KEY_LOGIN_PASSWORD          @"loginPassword"
#define KEY_REMIND_DATE				@"remindDate"
#define KEY_REMIND_STATE			@"remindState"

@implementation Config


+ (void) setLoginName : (NSString*)newLoginName
{
    [[NSUserDefaults standardUserDefaults] setObject:newLoginName forKey:KEY_LOGIN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) loginName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_LOGIN_NAME];
}

+ (void) setLoginPassword : (NSString*)newLoginPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:newLoginPassword forKey:KEY_LOGIN_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) loginPassword
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_LOGIN_PASSWORD];
}

+ (void) setRemindDateTime : (NSString *)strDate
{
	[[NSUserDefaults standardUserDefaults] setObject:strDate forKey:KEY_REMIND_DATE];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setRemindDate : (NSDateComponents *)date
{
	NSString * strDate = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_REMIND_DATE];
	NSDate * oldDate = [GlobalFunc convertStringToDate:strDate fmt:@"yyyy-MM-dd HH:mm"];
	
	if (oldDate == nil)
	{
		NSDate * curDate = [[NSCalendar currentCalendar] dateFromComponents:date];
		strDate = [GlobalFunc convertDateToString:curDate fmt:nil];
		[[NSUserDefaults standardUserDefaults] setObject:strDate forKey:KEY_REMIND_DATE];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	else
	{
		NSDateComponents * comps = [GlobalFunc convertNSDateToNSDateComponents:oldDate];
		
		// set only date
		comps.year = date.year;
		comps.month = date.month;
		comps.day = date.day;
		
		NSDate * curDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
		strDate = [GlobalFunc convertDateToString:curDate fmt:nil];
		[[NSUserDefaults standardUserDefaults] setObject:strDate forKey:KEY_REMIND_DATE];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (void) setRemindTime : (NSDateComponents *)date
{
	NSString * strDate = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_REMIND_DATE];
	NSDate * oldDate = [GlobalFunc convertStringToDate:strDate fmt:nil];
	
	if (oldDate == nil)
	{
		NSDateComponents * comps = [GlobalFunc convertNSDateToNSDateComponents:[NSDate date]];
		
		// set only hour & minute
		comps.hour = date.hour;
		comps.minute = date.minute;
		
		NSDate * curDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
		strDate = [GlobalFunc convertDateToString:curDate fmt:nil];
		[[NSUserDefaults standardUserDefaults] setObject:strDate forKey:KEY_REMIND_DATE];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	else
	{
		NSDateComponents * comps = [GlobalFunc convertNSDateToNSDateComponents:oldDate];
		
		// set only hour & minute
		comps.hour = date.hour;
		comps.minute = date.minute;
		
		NSDate * curDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
		strDate = [GlobalFunc convertDateToString:curDate fmt:nil];
		[[NSUserDefaults standardUserDefaults] setObject:strDate forKey:KEY_REMIND_DATE];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (NSDate *) loadRemindDate
{
	NSString * strDate = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_REMIND_DATE];
	if (stringNotNilOrEmpty(strDate)) {
		NSDate * date = [GlobalFunc convertStringToDate:strDate fmt:nil];
		return date;
	}
	return nil;
}

+ (void) setRemindAlarmState : (NSInteger)state
{
	[[NSUserDefaults standardUserDefaults] setInteger:state forKey:KEY_REMIND_STATE];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) loadRemindAlarmState
{
	NSInteger state = [[NSUserDefaults standardUserDefaults] integerForKey:KEY_REMIND_STATE];
	return state;
}

@end
