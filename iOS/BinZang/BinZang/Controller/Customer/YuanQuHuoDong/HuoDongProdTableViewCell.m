//
//  HuoDongProdTableViewCell.m
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "HuoDongProdTableViewCell.h"

@interface HuoDongProdTableViewCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

@property (nonatomic, retain) STProduct * mDataInfo;

@end

@implementation HuoDongProdTableViewCell

@synthesize mDataInfo;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData : (STProduct *)datainfo
{
	mDataInfo = datainfo;
	[_lblName setText:mDataInfo.title];
	[_lblPrice setText:mDataInfo.price_desc];
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:mDataInfo.image_url] placeholderImage:DEF_IMAGE];
	_txtAmount.text = [NSString stringWithFormat:@"%d", mDataInfo.req_count];
	_txtAmount.delegate = self;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	NSCharacterSet * characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
	if ([newString rangeOfCharacterFromSet:characterSet].location != NSNotFound)
	{
		return NO;
	}
	
	// check total amount
//	return [newString integerValue] < mDataInfo.amount;
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	mDataInfo.req_count = (int)[_txtAmount.text integerValue];
}

- (IBAction)onTapMinus:(id)sender
{
	int curNum = mDataInfo.req_count;
	
	if (curNum > 0) {
		curNum --;
		[_txtAmount setText:[NSString stringWithFormat:@"%d", curNum]];
	}
	mDataInfo.req_count = curNum;
}

- (IBAction)onTapPlus:(id)sender
{
	int curNum = mDataInfo.req_count;
	
	//if (curNum < mDataInfo.max_amount)
 	{
		curNum ++;
		[_txtAmount setText:[NSString stringWithFormat:@"%d", curNum]];
	}
	mDataInfo.req_count = curNum;
}
@end
