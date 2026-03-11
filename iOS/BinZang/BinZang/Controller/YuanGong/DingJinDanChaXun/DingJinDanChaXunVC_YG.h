//
//  DingJinDanChaXunVC_YG.h
//  BinZang
//
//  Created by Beids on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingJinDanCell_YG : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwFrame;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;

@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTombID;
@property (weak, nonatomic) IBOutlet UILabel *lblReciever;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@end

@interface DingJinDanChaXunVC_YG : CustomerSuperViewController
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet UIButton *btnZhiYing;
@property (weak, nonatomic) IBOutlet UIButton *btnDiaXiaoShang;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item;
- (IBAction)OnZhiYing:(id)sender;
- (IBAction)OnDaiXiaoShang:(id)sender;

@property BOOL		isOwnDingJinDan;
@property long		employee_id;
@end
