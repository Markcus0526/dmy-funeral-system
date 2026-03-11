//
//  BinZangZhiShiMainVC.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BinZangZhiShiMainVC.h"
#import "BinZangZhiShiDragonVC.h"

#import "BinZangOneDragonAreasVC.h"
#import "LingYuanMainVC.h"

@interface BinZangZhiShiMainVC ()
{
	LingYuanMainVC *lingYuanVC;
}
@property (weak, nonatomic) IBOutlet UIButton *btnOneDragon;
@property (weak, nonatomic) IBOutlet UIButton *btnTombKnowledge;
@property (weak, nonatomic) IBOutlet UIView *vwContDragon;
@property (weak, nonatomic) IBOutlet UIView *vwContTomb;
@end

@implementation BinZangZhiShiMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initControls
{
	for (UIViewController *vc in self.childViewControllers)
	{
		if ([vc isKindOfClass:[LingYuanMainVC class]])
			lingYuanVC = (LingYuanMainVC*)vc;
	}
	if (self.nState == 1) {
		self.navigationItem.title = @"殡葬新闻";
		[self setTombTab:YES];
	}
	else if (self.nState == 0){
		self.navigationItem.title = @"殡葬知识";
		[self setTombTab:NO];
	}
	else{
		self.navigationItem.title = @"一条龙服务";
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	
	if ([segue.identifier isEqualToString:@"embedFromZhiShiToDragon"])
	{
		BinZangZhiShiDragonVC * destCtrl = (BinZangZhiShiDragonVC *)segue.destinationViewController;
		destCtrl.parentVC = self;
	}
	else if ([segue.identifier isEqualToString:@"segueFromDragonToAreaList"])
	{
		BinZangOneDragonAreasVC * destCtrl = (BinZangOneDragonAreasVC *)segue.destinationViewController;
		destCtrl.nAreaId = [(STDragonServiceArea *)sender uid];
	}
}


- (void) gotoAreaListVC : (STDragonServiceArea *)areaInfo
{
	[self performSegueWithIdentifier:@"segueFromDragonToAreaList" sender:areaInfo];
}

- (IBAction)onTapOneDragon:(id)sender
{
	[_btnOneDragon setSelected:YES];
	[_btnTombKnowledge setSelected:NO];
	[_vwContDragon setHidden:NO];
	[_vwContTomb setHidden:YES];
}

- (IBAction)onTapTombKnowledge:(id)sender
{
	[self setTombTab:NO];
}

- (void) setTombTab : (BOOL)isNews
{
	if (isNews)
	{
		[lingYuanVC setNewType];
	}
	
	[_btnOneDragon setSelected:NO];
	[_btnTombKnowledge setSelected:YES];
	[_vwContDragon setHidden:YES];
	[_vwContTomb setHidden:NO];
}


@end
