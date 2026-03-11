//
//  QiPanShanJingDianVC.h
//  BinZang
//
//  Created by Beids on 5/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKLocationService.h"

@interface JingDianTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UITextView *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@property (weak, nonatomic) IBOutlet UIButton *btnAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnMain;

@end

@interface QiPanShanJingDianVC : VisitorSuperViewController <UIAlertViewDelegate, CLLocationManagerDelegate, BMKLocationServiceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblOffice;


@end
