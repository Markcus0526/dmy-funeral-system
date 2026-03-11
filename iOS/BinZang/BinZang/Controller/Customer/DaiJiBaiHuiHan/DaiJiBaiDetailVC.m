//
//  DaiJiBaiDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "DaiJiBaiDetailVC.h"

@implementation DaiJiBaiDetImgTableCell
@end

@interface DaiJiBaiDetailVC ()

@end

#define CELL_ID						@"cellDaiJiBaiDetImg"
#define CELL_HEIGHT					135

@implementation DaiJiBaiDetailVC

@synthesize mDeputyInfo;

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



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	[self callGetItemlist];
}

/**
 * update UI
 */
- (void) updateUI
{
	[_lblTime setText:mDeputyInfo.time];
	[_lblServe setText:mDeputyInfo.service_people];
	[_tblItems reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get deputy detail service
 */
- (void) callGetItemlist
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetDeputyLogDetail:mDeputyInfo.uid];
}

- (void) getDeputyLogDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDeputyLog *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mDeputyInfo = datainfo;
		[self updateUI];
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
	if (mDeputyInfo.detail_images == nil) {
		return 0;
	}
	
	return mDeputyInfo.detail_images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	DaiJiBaiDetImgTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	NSString * imgUrl = [mDeputyInfo.detail_images objectAtIndex:indexPath.row];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:imgUrl] placeholderImage:DEF_IMAGE];
	
	return cell;
}

@end
