//
//  BanShiChuDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeEmpTableCell : UITableViewCell


@end


@interface BanShiChuDetailVC : VisitorSuperViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readwrite) long mOfficeUid;
@property (nonatomic, retain) STOffice *		mOfficeInfo;
@end
