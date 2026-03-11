//
//  ShouHouMainVC.m
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShouHouMainVC.h"
#import "FuWuLeiVC.h"
#import "JiBaiYongPinVC.h"

@interface ShouHouMainVC ()
{
	NSMutableArray *				arrBurySvc;
	NSMutableArray *				arrDeputySvc;
	
	NSMutableArray *				arrItemlist;
}
@end

@implementation ShouHouMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self callGetAfterSvc];
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

- (void) updateUI
{
	for (id childVC in self.childViewControllers)
	{
		if ([childVC isKindOfClass:[FuWuLeiVC class]])
		{
			[(FuWuLeiVC *)childVC updateUI:arrBurySvc deputys:arrDeputySvc];
		}
		else if ([childVC isKindOfClass:[JiBaiYongPinVC class]])
		{
			[(JiBaiYongPinVC *)childVC updateUI:arrItemlist];
		}
	}
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get after service
 */
- (void) callGetAfterSvc
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetAfterService];
}

- (void) getAfterServiceResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STAfterService *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		arrBurySvc = datainfo.bury_services;
		arrDeputySvc = datainfo.deputy_services;
		
		[self callGetWorshipItems];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


/**
 * call get worship item service
 */
- (void) callGetWorshipItems
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetFuneralProducts];
}

- (void) getFuneralProdResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		arrItemlist = datalist;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction Relation

- (IBAction)onTapFst:(id)sender
{
	[_vwFst setHidden:NO];
	[_vwSec setHidden:YES];
	[_btnTabFst setSelected:YES];
	[_btnTabSec setSelected:NO];
}

- (IBAction)onTapSec:(id)sender
{
	[_vwFst setHidden:YES];
	[_vwSec setHidden:NO];
	[_btnTabFst setSelected:NO];
	[_btnTabSec setSelected:YES];
}
@end
