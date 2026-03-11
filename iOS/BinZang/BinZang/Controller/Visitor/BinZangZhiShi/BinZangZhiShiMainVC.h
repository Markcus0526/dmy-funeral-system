//
//  BinZangZhiShiMainVC.h
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BinZangZhiShiMainVC : VisitorSuperViewController


- (void) gotoAreaListVC : (STDragonServiceArea *)areaInfo;

@property (nonatomic, readwrite) int		nState;

@end
