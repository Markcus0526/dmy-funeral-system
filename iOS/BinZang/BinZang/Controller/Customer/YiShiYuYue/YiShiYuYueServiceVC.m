//
//  YiShiYuYueServiceVC.m
//  BinZang
//
//  Created by KimOkChol on 4/24/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "YiShiYuYueServiceVC.h"
#import "JiBaiYuYueProductVC.h"
#import "DaixiaoshangShouyeVC.h"
#import "MIConfirmViewController.h"

@interface YiShiServiceTableCell()
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnMain;
@end

@implementation YiShiServiceTableCell
@end

@interface YiShiYuYueServiceVC ()<MIConfirmDelegate>
{
	NSMutableArray *			arrItems;
	
	STBuryService * 			selBuryService;
}
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UITableView *tblItems;

@end


#define CELL_ID						@"cellYiShiBury"
#define CELL_HEIGHT					218
#define SEGUE_TO_JIBAI				@"segueFromBinZhangYiShi2To3"


@implementation YiShiYuYueServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
	roundRect(_btnNext, DEF_CORNER_RADIO);
	roundRect(_btnCancel, DEF_CORNER_RADIO);
	borderWidthColor(_btnCancel, 0.5, [UIColor darkGrayColor]);
	
	selBuryService = nil;
	[self callGetItemlist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)newItems
{
	arrItems = newItems;
	[_tblItems reloadData];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get qingren list service
 */
- (void) callGetItemlist
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
		
		[self updateUI:datainfo.bury_services];
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
	if (arrItems == nil) {
		return 0;
	}
	
	return arrItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	YiShiServiceTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	STBuryService * datainfo = (STBuryService *)[arrItems objectAtIndex:indexPath.row];
	[cell.lblTitle setText:datainfo.title];
	[cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.splash_image_url] placeholderImage:DEF_IMAGE];
	[cell.lblPrice setText:datainfo.price_desc];
	[cell.txtContent setText:datainfo.contents];
	[cell.btnPlay setTag:indexPath.row];
	[cell.btnMain setTag:indexPath.row];
	
	return cell;
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - UIAlertView Delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1)
	{
		[self performSegueWithIdentifier:SEGUE_TO_JIBAI sender:nil];
	}
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction

- (IBAction)onTapCheckbox:(id)sender
{
	UIButton * btnCheck = (UIButton *)sender;
	NSInteger pos = [btnCheck tag];
	
	for (int i = 0; i < arrItems.count; i++)
	{
		NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		YiShiServiceTableCell * cell = (YiShiServiceTableCell *)[_tblItems cellForRowAtIndexPath:indexPath];
		if (pos == i) {
			[cell.btnCheck setSelected:YES];
		} else {
			[cell.btnCheck setSelected:NO];
		}
	}
	
	STBuryService * datainfo = (STBuryService *)[arrItems objectAtIndex:pos];
	selBuryService = datainfo;
}

- (IBAction)onTapPlay:(id)sender
{
	UIButton * btnPlay = (UIButton *)sender;
	
	STBuryService * datainfo = (STBuryService *)[arrItems objectAtIndex:btnPlay.tag];
	// play video
	NSURL * movieUrl = [[NSURL alloc] initWithString:datainfo.video_url];
	
	MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:movieUrl];
	[self presentMoviePlayerViewControllerAnimated:playerViewController];
}

- (IBAction)onTapNext:(id)sender
{
	if (selBuryService == nil)
	{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:STR_ALERT message:MSG_NONE_YISHI delegate:self cancelButtonTitle:STR_BUTTON_CANCEL otherButtonTitles:STR_BUTTON_CONFIRM, nil];
		[alert show];
		return;
	}
	
	[self performSegueWithIdentifier:SEGUE_TO_JIBAI sender:nil];
}

- (IBAction)onTapCancel:(id)sender
{
	[self.view endEditing:YES];
	
	MIConfirmViewController *confVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MIConfirmViewController"];
	
	confVC.delegate = self;
	
	[self addChildViewController:confVC];
	[self.view addSubview:confVC.view];
	[confVC didMoveToParentViewController:self];
}

- (void) onConfirmOK
{
	UIViewController *viewCtrlr;
	long count = [self.navigationController.viewControllers count];
	
	for (long index = count - 1; index >= 0 ; index--)
	{
		viewCtrlr = [self.navigationController.viewControllers objectAtIndex:index];
		
		if ([viewCtrlr isKindOfClass:[MainSwipeViewController class]])
		{
			break;
		}
	}
	if (viewCtrlr)
	{
		[self.navigationController popToViewController:viewCtrlr animated:YES];
	}else{
		[self onTapBack:nil];
	}
}

- (void) onConfirmCancel
{
	[self willMoveToParentViewController:nil];
	
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:SEGUE_TO_JIBAI])
	{
		// set data
		
		if (!_tokenData)
		{
			_tokenData = [[NSMutableDictionary alloc] init];
		}
		if (selBuryService)
			[_tokenData setObject:selBuryService forKey:@"BuryInfo"];
		
		JiBaiYuYueProductVC * destCtrl = (JiBaiYuYueProductVC *)segue.destinationViewController;
		
		destCtrl.tokenData = _tokenData;
	}
}


@end
