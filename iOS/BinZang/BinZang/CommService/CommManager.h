//
//  CommManager.h
//  BinZang
//
//  Created by KimOkChol on 4/13/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "VisitorSvcMgr.h"
//#import "CustomerSvcMgr.h"
#import "ComSvcMgr.h"

/////////////////////////////////////////////////////////////
#pragma mark - Communication Manager Interface
@interface CommManager : NSObject

+ (CommManager *)getCommMgr;
- (void)loadCommModules;

@property (nonatomic, retain) ComSvcMgr * comSvcMgr;

@property (nonatomic, retain) CommManager *commMgr;

@end

