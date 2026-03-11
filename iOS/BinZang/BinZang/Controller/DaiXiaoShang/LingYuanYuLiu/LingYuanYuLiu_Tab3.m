//
//  LingYuanYuLiu_Tab3.m
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanYuLiu_Tab3.h"
#import "LingYuanYuLiuNavi.h"

#define CELL_WIDTH		40
#define CELL_HEIGHT		40

#define UNITBAR_WIDTH	20
#define UNITBAR_HEIGHT	20

@interface LingYuanYuLiu_Tab3 ()<UIScrollViewDelegate >

@property (weak, nonatomic) IBOutlet UIScrollView *vwScroll;
@property (weak, nonatomic) IBOutlet UIView *vwInformation;
@property (weak, nonatomic) IBOutlet UIView *vwInfoContent;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblAreaID;

@end

#define SEGUE_TO_DETAIL	@"segueLingYuanYuLiuNext"

@implementation LingYuanYuLiu_Tab3
{
	NSMutableArray *tombsList;
	NSArray *images;
	
	int 		cell_width;
	int			cell_height;
	
	long		nWidth;
	long		nHeight;
	
	long		nTomb_ID;
	
	UIScrollView *vertBar;
	UIScrollView *horizBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	cell_width = CELL_WIDTH;
	cell_height = CELL_HEIGHT;
	
	[self initControls];
};

- (void) viewWillAppear:(BOOL)animated
{
	_vwInformation.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}*/

#pragma mark - Utilities
-(void) initControls
{
	UIImage *image0 = [UIImage imageNamed:@"bk_tomb_kong"];
	UIImage *image1 = [UIImage imageNamed:@"bk_tomb_yibaoliu"];
	UIImage *image2 = [UIImage imageNamed:@"bk_tomb_yifuding"];
	UIImage *image3 = [UIImage imageNamed:@"bk_tomb_yigoumai"];
	
	images = @[image0, image1, image2, image3];
	
	roundRect(_btnPrev, DEF_CORNER_RADIO);
	roundRect(_vwInfoContent, DEF_CORNER_RADIO);
	roundRect(_btnOK, DEF_CORNER_RADIO);
	roundRect(_btnCancel, DEF_CORNER_RADIO);
	borderWidthColor(_btnCancel, 0.5, [UIColor lightGrayColor]);
	borderWidthColor(_btnPrev, 0.5, [UIColor lightGrayColor]);
	borderWidthColor(_infoImage, 0.5, [UIColor lightGrayColor]);
	
	[self initScrollView];
	////////////////////////
	long area_id = [[_tokenData objectForKey:@"tomb_area_id"] integerValue];
	[self callGetTomblist:area_id];
	//[self callGetTomblist:0];
}

-(void) initScrollView
{
	long nRows = [[_tokenData objectForKey:@"row_count"] integerValue];
	long nCols = [[_tokenData objectForKey:@"column_count"] integerValue];
	
	nWidth = nCols * cell_width;
	nHeight = nRows * cell_height;
	
	_vwScroll.delegate = self;
	
	[_vwScroll setContentSize:CGSizeMake(nWidth, nHeight)];
	
	[self.view layoutIfNeeded];
	CGRect scrFrame = _vwScroll.frame;
	
	CGRect frame;
	
	CGRect labelFrame;

	frame = CGRectMake(scrFrame.origin.x - UNITBAR_WIDTH, scrFrame.origin.y, UNITBAR_WIDTH, scrFrame.size.height - 60);
	vertBar = [[UIScrollView alloc] initWithFrame:frame];
	//vertBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.8 blue:0.8 alpha:0.8];
	[self.view addSubview:vertBar];
	
	[vertBar setContentSize:CGSizeMake(UNITBAR_WIDTH, nHeight)];
	labelFrame = CGRectMake(0, 0, UNITBAR_WIDTH, cell_height);
	for (long row = 0; row < nRows; row++)
	{
		labelFrame.origin.y = row * cell_height;
		UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
		label.textAlignment = NSTextAlignmentCenter;
		label.text = [NSString stringWithFormat:@"%ld", row + 1];
		label.textColor = [UIColor darkGrayColor];
		label.font = [UIFont systemFontOfSize:12];
		//label.backgroundColor = [UIColor purpleColor];
		[vertBar addSubview:label];
	}

	frame = CGRectMake(scrFrame.origin.x, scrFrame.origin.y - UNITBAR_HEIGHT, scrFrame.size.width, UNITBAR_HEIGHT);
	horizBar = [[UIScrollView alloc] initWithFrame:frame];
	//horizBar.backgroundColor = [UIColor colorWithRed:1 green:0.8 blue:0.8 alpha:0.8];
	[self.view addSubview:horizBar];
	
	[horizBar setContentSize:CGSizeMake(nWidth, UNITBAR_HEIGHT)];
	labelFrame = CGRectMake(0, 0, cell_width, frame.size.height);
	for (long col = 0; col < nCols; col++)
	{
		labelFrame.origin.x = col * cell_width;
		UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = [UIColor darkGrayColor];
		label.font = [UIFont systemFontOfSize:12];
		label.text = [NSString stringWithFormat:@"%ld", col + 1];
		//label.backgroundColor = [UIColor orangeColor];
		[horizBar addSubview:label];
	}
	vertBar.userInteractionEnabled = NO;
	horizBar.userInteractionEnabled = NO;
}

-(void) setTombsDatas:(NSMutableArray*)tombs
{
	tombsList = tombs;

	long posX, posY;
	UIButton *button;
	
	for (STTombItem *item in tombs)
	{
		posX = item.col * cell_width;
		posY = item.row * cell_height;
		
		button = [[UIButton alloc] initWithFrame:CGRectMake(posX, posY, cell_width, cell_height)];
		button.tag = item.uid;
		
		[button setImage:[images objectAtIndex:item.state] forState:UIControlStateNormal];
		
		[button addTarget:self action:@selector(onTapTomb:) forControlEvents:UIControlEventTouchUpInside];
		
		[_vwScroll addSubview:button];
	}
}

-(STTombItem*) getTombDatFromList:(long)tomb_id
{
	for (STTombItem *item in tombsList)
	{
		if (item.uid == tomb_id)
			return  item;
	}
	return nil;
}

-(void) onTapTomb : (id)sender
{
	UIButton *button = sender;
	long tombID = button.tag;
	STTombItem *item = [self getTombDatFromList:tombID];
	
	if (item.state != 0)
		return;
	
	[self callGetTombDetail:tombID];
}

-(void) setInformation : (STTomb*)detail
{
	_vwInformation.hidden = NO;
	
	nTomb_ID = detail.uid;
	_lblAreaID.text = detail.tomb_no;
	_lblPrice.text = detail.price_desc;
	_lblTypeNumber.text = detail.desc;
	[_infoImage setImageWithURL:[NSURL URLWithUnicodeString:detail.image_url] placeholderImage:DEF_IMAGE];

}

- (IBAction)onOK:(id)sender
{
	[_tokenData setObject:[NSNumber numberWithLong:nTomb_ID] forKey:@"tomb_site_id"];
	
	//reserve
	[self callReserveTomb];
	//[self performSegueWithIdentifier:SEGUE_TO_DETAIL sender:_tokenData];
}

- (IBAction)onCancel:(id)sender
{
	_vwInformation.hidden = YES;
}

#pragma mark - Service Module
/**
 * call get qingren list service
 */
- (void) callGetTomblist : (long)area_id
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetTombList:area_id];
}

- (void) getTombListResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self setTombsDatas:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) callGetTombDetail : (long)tomb_id
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetTombDetail:tomb_id];
}

- (void) getTombDetailResult		: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STTomb *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self setInformation:datainfo];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) callReserveTomb
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	NSString *customer_name = [_tokenData objectForKey:@"customer_name"];
	NSString *customer_phone = [_tokenData objectForKey:@"customer_phone"];
	NSString *death_people1 = [_tokenData objectForKey:@"death_people1"];
	NSString *mgr_people1 = [_tokenData objectForKey:@"mgr_people1"];
	NSString *death_people2 = [_tokenData objectForKey:@"death_people2"];
	NSString *mgr_people2 = [_tokenData objectForKey:@"mgr_people2"];
	
	long tomb_area_id = [[_tokenData objectForKey:@"tomb_area_id"] integerValue];
	long tomb_site_id = [[_tokenData objectForKey:@"tomb_site_id"] longValue];
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ReserveTombPlace : customer_name==nil?@"":customer_name
											 customer_phone:customer_phone==nil?@"":customer_phone
											  death_people1:death_people1==nil?@"":death_people1
												mgr_people1:mgr_people1==nil?@"":mgr_people1
											  death_people2:death_people2==nil?@"":death_people2
												mgr_people2:mgr_people2==nil?@"":mgr_people2
											   tomb_area_id:tomb_area_id
											   tomb_site_id:tomb_site_id
											 tomb_tablet_id:-1];
}

- (void) reserveTombPlaceResult:(NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:retmsg afterDelay:DEF_DELAY];
		
		LingYuanYuLiuNavi *navigation = (LingYuanYuLiuNavi*)self.navigationController;
		[navigation onOK:self];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self matchScrollView];
}

- (void) matchScrollView
{
	CGPoint offset = _vwScroll.contentOffset;
	
	offset.x = vertBar.contentOffset.x;
	vertBar.contentOffset = offset;
	
	offset = _vwScroll.contentOffset;
	offset.y = horizBar.contentOffset.y;
	horizBar.contentOffset = offset;
}
@end
