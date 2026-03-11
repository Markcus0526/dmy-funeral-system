//
//  DingJinDanListVC.m
//  BinZang
//
//  Created by KimOkChol on 5/11/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "DingJinDanListVC.h"
#import "DingJinDanChaXunVC_YG.h"

@interface DingJinDanListVC ()<ComSvcDelegate>
{
	STOffice *officeInfo;
	
	NSMutableArray *arrItems;
}
@property (weak, nonatomic) IBOutlet UITableView *tblList;
@end

@implementation DingJinDanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initControls
{
	[self callGetOfficeDetail];
}

- (void) updateUI
{
	arrItems = officeInfo.employees;
	[_tblList reloadData];
};
#pragma mark - Web Service Relation

/**
 * call get office detail info service
 */
- (void) callGetOfficeDetail
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficeDetail : [Common userInfo].office_id];
}

- (void) getOfficeDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STOffice *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		officeInfo = datainfo;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return arrItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
		
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	STOfficeEmp *emp = [arrItems objectAtIndex:indexPath.row];
	cell.textLabel.text = emp.name;
	cell.tag = emp.uid;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	DingJinDanChaXunVC_YG *vc = [[UIStoryboard storyboardWithName:@"YuanGong" bundle:nil] instantiateViewControllerWithIdentifier:@"SIDDingJinDanChaXun"];
	
	STOfficeEmp *emp = [arrItems objectAtIndex:indexPath.row];
	vc.isOwnDingJinDan = NO;
	vc.employee_id = emp.uid;
	
	[self.navigationController pushViewController:vc animated:YES];
	
}


@end
