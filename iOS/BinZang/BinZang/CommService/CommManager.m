//
//  CommManager.m
//  BinZang
//
//  Created by KimOkChol on 4/13/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "CommManager.h"

@implementation CommManager

@synthesize comSvcMgr;
@synthesize commMgr;

static CommManager *commMgr = nil;

+ (CommManager *)getCommMgr
{
	if (commMgr == nil) {
		commMgr = [[CommManager alloc] init];
		[commMgr loadCommModules];
	}
	
	return commMgr;
}

- (void)loadCommModules
{
	comSvcMgr = [[ComSvcMgr alloc] init];
}


@end
