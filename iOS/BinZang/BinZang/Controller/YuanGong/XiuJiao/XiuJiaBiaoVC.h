//
//  XiuJiaBiaoVC.h
//  BinZang
//
//  Created by Beids on 5/10/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface XiuJiaBiaoVC : CustomerSuperViewController

- (IBAction)OnPrevMonth:(id)sender;

- (IBAction)OnNextMonth:(id)sender;

- (IBAction)OnCancelButtonTouchUpInside:(id)sender;
- (IBAction)OnCancelButtonTouchUpOutside:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@end
