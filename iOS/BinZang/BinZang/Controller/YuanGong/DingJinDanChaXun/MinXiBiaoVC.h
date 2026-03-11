//
//  MinXiBiaoVC.h
//  BinZang
//
//  Created by Beids on 5/8/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MingXiBiaoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwFrame;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDealTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTombID;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@end

@interface MinXiBiaoVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItemss;

@property long employee_id;
@end
