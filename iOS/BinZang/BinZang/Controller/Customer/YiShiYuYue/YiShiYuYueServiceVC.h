//
//  YiShiYuYueServiceVC.h
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiShiServiceTableCell : UITableViewCell


@end

@interface YiShiYuYueServiceVC : VisitorSuperViewController <UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableDictionary *tokenData;
@end
