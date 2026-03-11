//
//  LingYuanYuLiu_Tab4.m
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanYuLiu_Tab4.h"
#import "LingYuanYuLiuNavi.h"

#pragma mark - LingYuanYuLiu_Tab4
@interface LingYuanYuLiu_Tab4 ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;
;

@end

@implementation LingYuanYuLiu_Tab4
{
	NSMutableArray *tombStones;
	
	STTombStoneArea *curArea;
	STTombStonePart *curPart;
	STTombStoneRow *curRow;
	STTombStoneIndex *curIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void) viewWillAppear:(BOOL)animated
{
	
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

#pragma mark - Utilities

- (void) initControls
{
	roundRect(_btnOK, DEF_CORNER_RADIO);
	roundRect(_btnPrev, DEF_CORNER_RADIO);
	borderWidthColor(_btnPrev, 0.5, [UIColor darkGrayColor]);
	[self callGetTombStonePlaces];
}

- (IBAction)onTapOK:(id)sender
{
	[self callReserveTombStone];
}

-(void) changePart : (long)index
{
	if (!curArea)return;
	curPart = [curArea.parts objectAtIndex:index];
	
	[_picker reloadComponent:1];
	[_picker selectRow:0 inComponent:1 animated:YES];
	[self changeRow:0];
}

-(void) changeRow : (long)index
{
	if (!curPart)return;
	curRow = [curPart.rows objectAtIndex:index];
	
	[_picker reloadComponent:2];
	[_picker selectRow:0 inComponent:2 animated:YES];
	[self changeIndex:0];
}

-(void) changeIndex : (long)index
{
	if (!curRow) return;
	curIndex = [curRow.indexes objectAtIndex:index];
}

- (void) setData : (NSMutableArray*)datalist
{
	if (datalist && datalist.count > 0)
	{
		tombStones = datalist;
		curArea = [datalist objectAtIndex:0];
		[_picker reloadComponent:0];
	
		[self changePart:0];
	}else{
		tombStones = nil;
		curArea = nil;
		curPart = nil;
		curRow = nil;
		curIndex = nil;
		_btnOK.enabled = NO;
		//_btnOK.hidden = YES;
		showToastWithDelay(MSG_EMPTY_PAIWEI,5);
	}
}

#pragma mark - Service Module
/**
 * call get qingren list service
 */
- (void) callGetTombStonePlaces
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetTombStonePlaces:[[_tokenData objectForKey:@"tomb_area_id"] integerValue]];
}

- (void) getTombStonePlacesResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self setData:datalist];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

- (void) callReserveTombStone
{
	if (!curArea || !curPart || !curRow || !curIndex)
	{
		showToast(@"Cannot reserve.");
		return;
	}
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
	
	long tomb_tablet_id = curIndex.tablet_id;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ReserveTombPlace : customer_name==nil?@"":customer_name
											customer_phone:customer_phone==nil?@"":customer_phone
											 death_people1:death_people1==nil?@"":death_people1
											   mgr_people1:mgr_people1==nil?@"":mgr_people1
											 death_people2:death_people2==nil?@"":death_people2
											   mgr_people2:mgr_people2==nil?@"":mgr_people2
											  tomb_area_id:tomb_area_id
												   tomb_site_id:tomb_site_id
											 tomb_tablet_id:tomb_tablet_id];
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

#pragma mark - UIPickerViewDatasource, UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (component) {
		case 0:
			return [curArea.parts count];
		case 1:
			return [curPart.rows count];
		case 2:
			return [curRow.indexes count];
	}
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	switch (component) {
		case 0:
		{
			STTombStonePart *part = [curArea.parts objectAtIndex:row];
			return [NSString stringWithFormat:@"%ld", part.uid];
		}
		case 1:
		{
			STTombStoneRow *rrow = [curPart.rows objectAtIndex:row];
			return [NSString stringWithFormat:@"%ld", rrow.uid];
		}
		case 2:
		{
			STTombStoneIndex *index = [curRow.indexes objectAtIndex:row];
			return [NSString stringWithFormat:@"%ld", index.uid];
		}
	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	switch (component) {
		case 0:
			[self changePart:row];
			break;
		case 1:
			[self changeRow:row];
			break;
		case 2:
			[self changeIndex:row];
			break;
	}
}

@end
