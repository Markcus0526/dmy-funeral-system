//
//  ZhangDanDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillDetProductTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblContents;

@end

@interface ZhangDanDetailVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UILabel *lblBillType;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyTime;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblServeType;
@property (weak, nonatomic) IBOutlet UILabel *lblServePrice;

@property (weak, nonatomic) IBOutlet UITableView *tblProducts;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblUseTime;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@property (weak, nonatomic) IBOutlet UITextView *txtRemark;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constProdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constRemarkHeight;

@property (nonatomic, retain) STBill *			mBillInfo;

@end
