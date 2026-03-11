//
//  SanLiuJingVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "SanLiuJingVC.h"
#import "SanLiuDetailVC.h"

@implementation SanLiuJingTableCell
@end

@interface SanLiuJingVC ()
{
	NSMutableArray *			arrViews;
}
@end


#define CELL_ID						@"cell36View"
#define CELL_HEIGHT					70
#define SEGUE_TO_DETAIL				@"segueFrom36ViewToDetail"

@implementation SanLiuJingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
	{
		// get current office data
		UIButton * button = (UIButton *)sender;
		ST36View * datainfo = (ST36View *)[arrViews objectAtIndex:button.tag];
		// set data
		SanLiuDetailVC * destCtrl = (SanLiuDetailVC *)segue.destinationViewController;
		destCtrl.mViewInfo = datainfo;
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	[self callGetViewlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems;
{
	arrViews = arrItems;
	[_tblViews reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get 36 view list service
 */
- (void) callGetViewlist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] Get36Views];
}

- (void) get36ViewsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self updateUI:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if (arrViews == nil) {
		return 0;
	}
	
	return arrViews.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	SanLiuJingTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[SanLiuJingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	ST36View * datainfo = (ST36View *)[arrViews objectAtIndex:indexPath.row];
	[cell.lblTitle setText:datainfo.title];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
	borderWidthColor(cell.imgMain, 1, [UIColor grayColor]);
	[cell.btnMain setTag:indexPath.row];
	
	return cell;
}


@end
