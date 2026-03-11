//
//  POPDSectionTableViewCell.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "POPDSectionTableViewCell.h"

@implementation POPDSectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) expand
{
//	[UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//		self.imgArrowMark.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
//	} completion:NULL];
	
//	CABasicAnimation * rotationAnimation;
//	rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//	rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI_2];
//	rotationAnimation.duration = 0.3;
//	rotationAnimation.cumulative = YES;
//	rotationAnimation.repeatCount = 1;
//	
//	[self.imgArrowMark.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
	
	self.imgArrowMark.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
}

- (void) collapse
{
	[UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		self.imgArrowMark.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
	} completion:NULL];
}

@end
