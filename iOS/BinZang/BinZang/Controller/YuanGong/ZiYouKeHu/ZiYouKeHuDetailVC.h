//
//  ZiYouKeHuDetailVC.h
//  BinZang
//
//  Created by Beids on 5/9/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiYouKeHuDetailTblCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@end

@interface ZiYouKeHuDetailVC : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCustomer;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@property (weak, nonatomic) IBOutlet UILabel *lblAgent;
@property (weak, nonatomic) IBOutlet UILabel *lbl_reserver_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_service_type;

@property (weak, nonatomic) IBOutlet UILabel *lblState;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBuyInfoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContentViewHeight;

@property (weak, nonatomic) IBOutlet UITableView *tblItems;

@property (nonatomic, retain) STBuyProductLogDetail *		mDetailInfo;
@property (nonatomic, readwrite) long log_id;


@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIScrollView *scv;
@property (weak, nonatomic) IBOutlet UIView *cv;


@end
