//
//  BinZangOneDragonAreasVC.h
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragonAreaTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblContents;
@property (weak, nonatomic) IBOutlet UIButton *btnMain;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;


@end

@interface BinZangOneDragonAreasVC : VisitorSuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tblAreas;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (nonatomic, readwrite) long	nAreaId;


@end
