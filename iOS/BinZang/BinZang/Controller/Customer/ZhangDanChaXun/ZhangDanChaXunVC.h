//
//  ZhangDanChaXunVC.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhangDanTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnMain;

@end

@interface ZhangDanChaXunVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

@end
