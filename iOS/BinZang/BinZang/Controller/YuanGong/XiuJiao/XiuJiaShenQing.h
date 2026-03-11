//
//  XiuJiaShenQing.h
//  BinZang
//
//  Created by Beids on 5/11/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuJiaShenQing : CustomerSuperViewController
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
- (IBAction)OnChangedDate:(id)sender;

- (IBAction)OnClickSubmit:(id)sender;

- (IBAction)OnClickLieXiu:(id)sender;
- (IBAction)OnClickBingXiu:(id)sender;
- (IBAction)OnClickQiTa:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgNormal;
@property (weak, nonatomic) IBOutlet UIImageView *imgIll;
@property (weak, nonatomic) IBOutlet UIImageView *imgOther;
@property (weak, nonatomic) IBOutlet UIView *vwOptions;

@end
