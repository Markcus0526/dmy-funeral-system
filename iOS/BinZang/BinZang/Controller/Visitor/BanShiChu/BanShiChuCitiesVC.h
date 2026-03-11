//
//  BanShiChuCitiesVC.h
//  BinZang
//
//  Created by Beids on 5/15/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCitiesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

- (IBAction)OnClickCell:(id)sender;
@end

@interface BanShiChuCitiesVC :  VisitorSuperViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblCities;


@end
