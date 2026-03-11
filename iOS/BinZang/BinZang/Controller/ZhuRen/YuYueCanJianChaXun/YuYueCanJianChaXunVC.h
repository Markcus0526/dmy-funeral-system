//
//  YuYueCanJianChaXunVC.h
//  BinZang
//
//  Created by KimOkChol on 5/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYueCanJianCell : UITableViewCell
@end

@interface YuYueCanJianChaXunVC : CustomerSuperViewController
- (void) CancelReserve : (long)log_id log:(STReserveLog*)log;
- (void) ConfirmReserve : (long)log_id log:(STReserveLog*)log;
@end
