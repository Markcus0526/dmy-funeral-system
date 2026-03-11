//
//  BanShiChuListVC.h
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKLocationService.h"

@interface OfficeTableCell : UITableViewCell

@end

@interface BanShiChuListVC : VisitorSuperViewController <UIAlertViewDelegate, CLLocationManagerDelegate, BMKLocationServiceDelegate>

@property (nonatomic, retain) NSMutableArray *		mOfficesInfo;

- (void) gotoDaoFanAddress:(NSInteger)tag;

@end
