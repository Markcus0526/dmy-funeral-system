//
//  ChuQinOfficeDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VocationItemCell : UITableViewCell

@end

@interface ChuQinOfficeDetailVC : CustomerSuperViewController

- (void) setDetailInfo : (NSString*)title vocations:(NSMutableArray*)dailyVocations;

@end
