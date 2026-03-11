//
//  HuoDongProdPurchase.h
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayProdTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblProdType;
@property (weak, nonatomic) IBOutlet UILabel *lblProdName;
@property (weak, nonatomic) IBOutlet UILabel *lblProdCount;
@property (weak, nonatomic) IBOutlet UILabel *lblProdPrice;
@property (weak, nonatomic) IBOutlet UIView *vwContainer;

@end

@interface HuoDongProdPurchase : CustomerSuperViewController

@property (weak, nonatomic) IBOutlet UIView *vwContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblIsInstead;
@property (weak, nonatomic) IBOutlet UILabel *lblServicePrice;
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;


@property (nonatomic, retain) NSMutableArray *			mSelProducts;
@property (nonatomic, retain) NSString *				mStrTime;
@property (nonatomic, readwrite) double					mTotalPrice;
@property (nonatomic, retain) STBuryService *			mBurySvcInfo;
@property (nonatomic, retain) NSString *				mStrType;
@property (nonatomic, readwrite) long					mTombId;
@property (nonatomic, readwrite) long					mCustomerID;
@property (nonatomic, readwrite) BOOL					mIs_DeputyService;

- (IBAction)onTapConfirm:(id)sender;


@end
