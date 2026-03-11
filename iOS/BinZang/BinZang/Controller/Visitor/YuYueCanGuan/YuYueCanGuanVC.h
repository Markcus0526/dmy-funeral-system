//
//  YuYueCanGuanVC.h
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIListView.h"

@interface TableCellForYYCG:UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnContent;

- (IBAction)OnClickCell:(id)sender;
@end

@interface YuYueCanGuanVC : VisitorSuperViewController<UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *vwPhone;
@property (weak, nonatomic) IBOutlet UIView *vwName;
@property (weak, nonatomic) IBOutlet UIView *vwCurCity;
@property (weak, nonatomic) IBOutlet UIView *vwOffice;
@property (weak, nonatomic) IBOutlet UIView *vwDate;

@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblOffice;


@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnOffice;

@property (weak, nonatomic) IBOutlet UIView *vwSelector;
@property (strong, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSelectHeight;

- (IBAction)OnChangeDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)onTapConfirm:(id)sender;

- (IBAction)OnClickBtnCity:(id)sender;
- (IBAction)OnClickOfficeID:(id)sender;

- (void) OnClickTblCell:(NSInteger) nIndex;
- (IBAction)OnClickSubmit:(id)sender;

@end
