//
//  FuWuLeiVC.m
//  BinZang
//
//  Created by KimOkChol on 4/16/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "FuWuLeiVC.h"


@interface BuryTableCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *txtContent;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

@property float height;
@end

@implementation BuryTableCell

-(void) setData : (STBuryService*)datainfo tag:(NSInteger)tag
{
	[_lblTitle setText:datainfo.title];
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.splash_image_url] placeholderImage:DEF_IMAGE];
	[_txtContent setText:datainfo.contents];
	[_txtContent sizeToFit];
	
	_height = _txtContent.frame.size.height + 210;
	[_txtContent setText:datainfo.contents];
	[_btnPlay setTag:tag];
	borderWidthColor(_imgMain, 0.5, [UIColor blackColor]);
}
@end

@interface InstWorshipCell()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIWebView *wvContents;

@property float height;
@end

@implementation InstWorshipCell
- (void) setData : (STDeputyService*)deputy
{
	_wvContents.userInteractionEnabled = NO;
	_wvContents.delegate = self;
	[_wvContents loadHTMLString:deputy.contents baseURL:nil];
	if (deputy.title)
		[_lblTitle setText:deputy.title];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
	CGRect frame = webView.frame;
	
	CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
	frame.size = fittingSize;
	webView.frame = frame;

	_height = fittingSize.height + 70;
}
@end

@interface FuWuLeiVC ()<UITableViewDelegate, UITableViewDataSource>
{
	NSMutableArray *				arrBurySvc;
	NSMutableArray *				arrDeputySvc;
	
	int						height;
}
@property (weak, nonatomic) IBOutlet UITableView *tblService;
@end


#define CELL_BURY_HEIGHT			240
#define CELL_INST_HEIGHT			260

#define CELL_BURY_ID				@"cellBurySvc"
#define CELL_DEPUTY_ID				@"cellDeputySvc"

@implementation FuWuLeiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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



/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrBury deputys:(NSMutableArray *)arrDeputy;
{
	arrBurySvc = arrBury;
	arrDeputySvc = arrDeputy;
	
	[_tblService layoutIfNeeded];
	
	CGRect frame = _tblService.frame;
	
	height = 100 + (frame.size.width - 20 - 20) / 2;

	[_tblService reloadData];
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0)
 	{
		if (arrBurySvc == nil || arrDeputySvc == nil)
			
			return 0;
		
		return arrBurySvc.count;
	}
	else
	{
		// Return the number of rows in the section.
		if (arrBurySvc == nil || arrDeputySvc == nil)
			return 0;
		return arrDeputySvc.count;
	}
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
	if (indexPath.section == 0)
	{
		return height + 20;
	}else
		return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = indexPath.row;
	NSInteger section = indexPath.section;
	
	if (section == 0)
 	{
		BuryTableCell *cell = (BuryTableCell*)((STBuryService*)[arrBurySvc objectAtIndex:row]).user_data;
		float hei = cell.height;
		height = 10 * row;
		return cell.height;
	}
	else
	{
		InstWorshipCell *cell = (InstWorshipCell*)((STDeputyService*)[arrDeputySvc objectAtIndex:row]).user_data;
		float hei = cell.height;
		hei = 100;
		return cell.height;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell;
	
	if (indexPath.section == 0)
	{
		if (indexPath.row == 4)
		{
			int a = 0;
		}
		NSString* szID = CELL_BURY_ID;
		BuryTableCell * instCell = [tableView dequeueReusableCellWithIdentifier:szID];
		
		if (instCell == nil)
		{
			instCell = [[BuryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
		}
		
		STBuryService * datainfo = (STBuryService *)[arrBurySvc objectAtIndex:indexPath.row];
		datainfo.user_data = instCell;
		[instCell setData:datainfo tag:indexPath.row];
		cell = instCell;
	}
	else
	{
		NSString* szID = CELL_DEPUTY_ID;
		InstWorshipCell * instCell = [tableView dequeueReusableCellWithIdentifier:szID];
		
		if (instCell == nil)
		{
			instCell = [[InstWorshipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
		}
		STDeputyService *deputy = [arrDeputySvc objectAtIndex:indexPath.row];
		deputy.user_data = instCell;
		[instCell setData:deputy];
		cell = instCell;
	}
	
	return cell;
}

- (IBAction)onTapPlay:(id)sender
{
	UIButton * btnPlay = (UIButton *)sender;
	
	STBuryService * datainfo = (STBuryService *)[arrBurySvc objectAtIndex:btnPlay.tag];
	// play video
	NSURL * movieUrl = [[NSURL alloc] initWithString:datainfo.video_url];
	
	MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:movieUrl];
	[self presentMoviePlayerViewControllerAnimated:playerViewController];
}


@end
