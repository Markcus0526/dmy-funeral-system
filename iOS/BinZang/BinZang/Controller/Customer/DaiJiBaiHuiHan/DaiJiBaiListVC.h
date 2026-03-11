//
//  DaiJiBaiListVC.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiJiBaiTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UIButton *btnMain;

@end

@interface DaiJiBaiListVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

@end
