//
//  CustomerSwipeMainViewController.m
//  BinZang
//
//  Created by KimOkChol on 4/28/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "CustomerSwipeMainViewController.h"
#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "Common.h"
#import "Config.h"

#define SWIPE_VC_ID							@"vcCusMain"

@interface CustomerSwipeMainViewController ()
@end

@implementation CustomerSwipeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	int user_type = [Common userInfo].user_type;
	
	UIViewController * customVC;
	
	NSString *username = [Common userInfo].name;
	NSString *strName;
	if (stringNotNilOrEmpty(username))
	 	strName = [NSString stringWithFormat:@"%@, ", username];
	else
		strName = @"";
	switch (user_type) {
		case UserType_DongShiZhang:
		case UserType_ZongJingLi:
		case UserType_FuZongJingLi:
			customVC = [[UIStoryboard storyboardWithName:@"LingDao" bundle:nil] instantiateViewControllerWithIdentifier:@"vcLingDaoMain"];
			customVC.navigationItem.title = [NSString stringWithFormat:@"%@您好！", strName];
			break;
		case UserType_ZhuRen:
			customVC = [[UIStoryboard storyboardWithName:@"ZhuRen" bundle:nil] instantiateViewControllerWithIdentifier:@"vcZhuRenMain"];
			customVC.navigationItem.title = [NSString stringWithFormat:@"主任 %@您好！", strName];
			break;
		case UserType_FuZhuRen:
			customVC = [[UIStoryboard storyboardWithName:@"ZhuRen" bundle:nil] instantiateViewControllerWithIdentifier:@"vcZhuRenMain"];
			customVC.navigationItem.title = [NSString stringWithFormat:@"付主任 %@您好！", strName];
			break;
		case UserType_YuanGong:
			customVC = [[UIStoryboard storyboardWithName:@"YuanGong" bundle:nil] instantiateViewControllerWithIdentifier:@"vcYuanGongMain"];
			customVC.navigationItem.title = [NSString stringWithFormat:@"%@您好！", strName];
			break;
		case UserType_DaiXiaoShang:
			customVC = [[UIStoryboard storyboardWithName:@"DaiXiaoShang" bundle:nil] instantiateViewControllerWithIdentifier:@"vcDXSMain"];
			customVC.navigationItem.title = [NSString stringWithFormat:@"%@您好！", @"业务经理, "];
			break;
		default:
			customVC = [self.storyboard instantiateViewControllerWithIdentifier:SWIPE_VC_ID];
			customVC.navigationItem.title = [NSString stringWithFormat:@"%@您好！", strName];
			break;
	}
	[self setViewControllers:@[customVC] animated:NO];
}

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
@end
