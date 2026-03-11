//
//  QuanJingDetailVC.h
//  BinZang
//
//  Created by Admin on 20/04/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuanJingDetailCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@property (weak, nonatomic) IBOutlet UITextView *mYouLaiText;
@property (weak, nonatomic) IBOutlet UILabel *mPriceDescLabel;
@end

@interface QuanJingDetailVC : VisitorSuperViewController
@property (nonatomic) int nUidOfQuanJing;

@property (nonatomic, retain) STAreaPointDetail *		mDetailInfo;

@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *mSubTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *mContentTextView;
@end
