//
//  QingRenShuJuVC.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QingRenTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblRelative;
@property (weak, nonatomic) IBOutlet UILabel *lblArea;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblDeathday;

@end

@interface QingRenShuJuVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

@end
