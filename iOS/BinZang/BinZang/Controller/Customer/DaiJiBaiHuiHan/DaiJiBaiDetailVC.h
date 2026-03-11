//
//  DaiJiBaiDetailVC.h
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiJiBaiDetImgTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;

@end

@interface DaiJiBaiDetailVC : CustomerSuperViewController


@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblServe;


@property (nonatomic, retain) STDeputyLog *		mDeputyInfo;

@end
