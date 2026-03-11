//
//  BinZangZhiShiDragonVC.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BinZangZhiShiDragonVC.h"
#import "POPDViewController.h"
#import "BinZangOneDragonAreasVC.h"
#import "BinZangZhiShiMainVC.h"

@interface BinZangZhiShiDragonVC () <POPDDelegate>
{
	NSMutableArray *			arrSvcAreas;
}
@end

@implementation BinZangZhiShiDragonVC

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

- (void) initControls
{
	[self callGetAreas];
}

- (void) updateUI
{
	NSMutableArray * menu = [[NSMutableArray alloc] init];
	for (STDragonServiceCity * oneCity in arrSvcAreas)
	{
		NSMutableArray * subSection = [[NSMutableArray alloc] init];
		for (STDragonServiceArea * oneArea in oneCity.areas)
		{
			[subSection addObject:oneArea.name];
		}
		NSDictionary * section = [NSDictionary dictionaryWithObjectsAndKeys:
								  oneCity.name, kheader,
								  subSection, ksubSection,
								  nil];
		[menu addObject:section];
	}
	
	POPDViewController *popMenu = [[POPDViewController alloc]initWithMenuSections:menu];
	popMenu.delegate = self;
	CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	popMenu.view.frame = rect;
	[self addChildViewController:popMenu];
	[self.view addSubview:popMenu.view];
	
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

- (void) callGetAreas
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOneDragonAreas];
}

- (void) getOneDragonAreasResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		arrSvcAreas = datalist;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


#pragma mark POPDViewController delegate

-(void) didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
//	NSLog(@"didSelectRowAtIndexPath: %d,%d",indexPath.section,indexPath.row);
	
	if (indexPath.row > 0)
	{
		// get selected data
		STDragonServiceCity * svcInfo = (STDragonServiceCity *)[arrSvcAreas objectAtIndex:indexPath.section];
		STDragonServiceArea * areaInfo = (STDragonServiceArea *)[svcInfo.areas objectAtIndex:indexPath.row - 1];
		
		[self performSelector:@selector(gotoAreaListVC:) withObject:areaInfo afterDelay:0.7];
	}
}

- (void) gotoAreaListVC : (STDragonServiceArea *)areaInfo
{
//	[self.presentingViewController pushViewController:viewCtrl animated:YES];
	[(BinZangZhiShiMainVC *)_parentVC gotoAreaListVC:areaInfo];
}


@end
