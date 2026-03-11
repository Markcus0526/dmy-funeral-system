//
//  FuWuLeiVC.h
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuryTableCell : UITableViewCell
@end

@interface InstWorshipCell : UITableViewCell
@end

@interface FuWuLeiVC : VisitorSuperViewController
- (void) updateUI : (NSMutableArray *)arrBury deputys:(NSMutableArray *)arrDeputy;

@end
