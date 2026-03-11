//
//  DaiXaioRenYuan.h
//  BinZang
//
//  Created by Beids on 5/8/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DaiXaioRenYuanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwFrame;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDangYue;
@property (weak, nonatomic) IBOutlet UILabel *lblBanNian;
@property (weak, nonatomic) IBOutlet UILabel *lblNianDo;
@end

@interface DaiXaioRenYuanVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItemss;

@end