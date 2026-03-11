//
//  LingYuanYuLiuVC.m
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanYuLiuVC.h"
#import "LingYuanYuLiuNavi.h"
#import "MIConfirmViewController.h"

@interface LingYuanYuLiuVC ()<LingYuanYuLiuDelegate, MIConfirmDelegate>

@end

@implementation LingYuanYuLiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
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

#pragma mark - Utilities
- (void) initControls
{
	UIViewController *viewCtrl = [self.childViewControllers objectAtIndex:0];
	if ([viewCtrl isKindOfClass:[LingYuanYuLiuNavi class]])
	{
		((LingYuanYuLiuNavi*)viewCtrl).lyylDelegate = self;
	}
	
}

- (IBAction)onTapBack:(id)sender
{
	MIConfirmViewController *confVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MIConfirmViewController"];
	
	confVC.delegate = self;
	
	[self addChildViewController:confVC];
	[self.view addSubview:confVC.view];
	[confVC didMoveToParentViewController:self];
}

#pragma mark - LingYuanYuLiuDelegate

-(void) view:(UIViewController*)sender onOK:(id)extra
{
	MyLog(@"LingYuanYuLiu : Success at %@", sender);

	showToast(@"操作成功！");
	[super onTapBack:sender];
}

-(void) view:(UIViewController*)sender onCancel:(id)extra
{
	MyLog(@"LingYuanYuLiu : Canceled at %@", sender);
	//confirm
	[self onTapBack:sender];
}

- (void) onConfirmOK
{
	[super onTapBack:self];
}

- (void)onConfirmCancel
{
	[self willMoveToParentViewController:nil];
}
@end
