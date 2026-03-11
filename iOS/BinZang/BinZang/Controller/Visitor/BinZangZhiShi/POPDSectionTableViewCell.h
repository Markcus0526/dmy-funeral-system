//
//  POPDSectionTableViewCell.h
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POPDSectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgArrowMark;

- (void) expand;
- (void) collapse;

@end
