//
//  JiBaiYongPinVC.h
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorshipItemTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;

@end

@interface JiBaiYongPinVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

- (void) updateUI : (NSMutableArray *)arrItems;

@end
