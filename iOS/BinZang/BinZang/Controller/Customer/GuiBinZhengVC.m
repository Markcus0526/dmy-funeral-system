//
//  GuiBinZhengVC.m
//  BinZang
//
//  Created by KimOkChol on 5/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "GuiBinZhengVC.h"
#import "UIImageView+AFNetworking.h"

@interface GuiBinZhengVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgGuiBinZheng;

@end

@implementation GuiBinZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initControls
{
	self.view.backgroundColor = [UIColor blackColor];
	_imgGuiBinZheng.contentMode = UIViewContentModeScaleAspectFit;
	[_imgGuiBinZheng setImageWithURL:[NSURL URLWithUnicodeString:[Common userInfo].credential_image] placeholderImage:DEF_IMAGE];
}
@end
