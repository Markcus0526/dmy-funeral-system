//
//  ChuQinNeiRongListVC.m
//  BinZang
//
//  Created by KimOkChol on 5/5/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ChuQinNeiRongListVC.h"
#import "POPDViewController.h"
#import "ChuQinOfficeVC.h"

#pragma mark ChuQinNeiRongListVC

@interface ChuQinNeiRongListVC ()<POPDDelegate>
{
	NSMutableArray *cities;
}
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@end

@implementation ChuQinNeiRongListVC

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
	[self callGetOfficeList];
}

/**
 * update UI
 */
- (void) updateUI
{
	NSMutableArray * menu = [[NSMutableArray alloc] init];
	for (STOfficeCity * oneCity in cities)
	{
		NSMutableArray * subSection = [[NSMutableArray alloc] init];
		for (STOfficeCityItem * oneArea in oneCity.offices)
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

	popMenu.view.frame = _vwMain.frame;
	[self addChildViewController:popMenu];
	[self.view addSubview:popMenu.view];
	
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation
- (void) callGetOfficeList
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficeList];
}

- (void) GetOfficeListResult 		: (NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		cities = datalist;
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
		STOfficeCity * svcInfo = (STOfficeCity *)[cities objectAtIndex:indexPath.section];
		STOfficeCityItem * areaInfo = (STOfficeCityItem *)[svcInfo.offices objectAtIndex:indexPath.row - 1];
		
		[self performSegueWithIdentifier:@"segueOfficeChuQin" sender:areaInfo];
	}
}

#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueOfficeChuQin"])
	{
		ChuQinOfficeVC *officeVC = segue.destinationViewController;
		STOfficeCityItem *office = (STOfficeCityItem*)sender;
		officeVC.office_id = office.uid;
		officeVC.officeName = office.name;
	}
}

@end
