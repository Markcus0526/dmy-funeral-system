//
//  XiuJiaoLieBiaoVC.h
//  BinZang
//
//  Created by Beids on 5/10/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuJiaoQuQiaoCell : UITableViewCell<ComSvcDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblReason;
- (IBAction)OnClickCancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *vwFrame;

@end

@interface XiuJiaoLieBiaoVC : CustomerSuperViewController
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
-(void) initControls;
@end
