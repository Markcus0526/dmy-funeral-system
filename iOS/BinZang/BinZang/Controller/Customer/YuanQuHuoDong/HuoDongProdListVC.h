//
//  HuoDongProdListVC.h
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuoDongProdTableViewCell.h"
#import "CustomPickerDefine.h"

@interface HuoDongProdListVC : CustomerSuperViewController <MISelectorDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

- (IBAction)onTapPurchase:(id)sender;

@end
