//
//  YuYueCanGuanVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "YuYueCanGuanVC.h"

#define CELL_HEIGHT 40

@interface TableCellForYYCG()
{
    YuYueCanGuanVC *parentVC;
    int nIndex;
    NSString *mDateStr;
}
@end

@implementation TableCellForYYCG

-(void) setValue : (NSString*)value : (YuYueCanGuanVC*)pVC : (int) index
{
    [_btnContent setTitle:value
                 forState:UIControlStateNormal];
    parentVC = pVC;
    nIndex = index;
}

- (IBAction)OnClickCell:(id)sender {
    [parentVC OnClickTblCell:(NSInteger*)nIndex];
}

@end

@interface YuYueCanGuanVC ()
{
    NSMutableArray *			arrOffices;
    NSArray *_pickerData;
    
    int nCity;
    int nSubId;
    
    int selectType; //0:city, 1:office
    
    int nHour;
}
@end

@implementation YuYueCanGuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectType = 0;
    
	[self initControls];
	[self initInputControls];
    [self callGetOfficeIntros];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_txtPhone becomeFirstResponder];
    _vwSelector.hidden = YES;
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
	roundRect(_vwName, DEF_CORNER_RADIO);
	roundRect(_vwPhone, DEF_CORNER_RADIO);
    roundRect(_vwCurCity, DEF_CORNER_RADIO);
    roundRect(_vwOffice, DEF_CORNER_RADIO);
	roundRect(_btnConfirm, DEF_CORNER_RADIO);
	
	borderWidthColor(_vwName, 1, [UIColor grayColor]);
	borderWidthColor(_vwPhone, 1, [UIColor grayColor]);
    borderWidthColor(_vwOffice, 1, [UIColor grayColor]);
    borderWidthColor(_vwCurCity, 1, [UIColor grayColor]);
    borderWidthColor(_vwDate, 1, [UIColor grayColor]);
    //borderWidthColor(_btnConfirm, 1, [UIColor grayColor]);
    
    _pickerData = @[@"0时",@"1时", @"2时", @"3时", @"4时", @"5时", @"6时", @"7时", @"8时", @"9时", @"10时", @"11时", @"12时", @"13时", @"14时", @"15时", @"16时", @"17时", @"18时", @"19时", @"20时", @"21时", @"22时", @"23时"];
    
    _hourPicker.dataSource = self;
    _hourPicker.delegate = self;
    
    self.tblItems.dataSource = self;
    self.tblItems.delegate = self;
    _tblItems.dataSource = self;
    _tblItems.delegate = self;
    //[_hourPicker selectRow:5 inComponent:0 animated:YES];
    
    [_btnCity addTarget:self action:@selector(setHighlighted:) forControlEvents:UIControlEventTouchDown];    
    [_btnOffice addTarget:self action:@selector(setHighlighted:) forControlEvents:UIControlEventTouchDown];
}

/**
 * call get office list service
 */
- (void) callGetOfficeIntros
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetOfficeIntros];
}

- (void) getOfficeIntrosResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
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

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems
{
    //arrOffices = arrItems;
    arrOffices = [[NSMutableArray alloc] init];
    for ( int i = 0; i < arrItems.count; i++)
    {
        STOfficeCity *cityInfos = (STOfficeCity *)[arrItems objectAtIndex:i];
        if ( cityInfos.offices != nil && cityInfos.offices.count > 0 )
            [arrOffices addObject:cityInfos];
    }
    
    if ( arrOffices.count > 0 )
    {
        nCity = 0;
        nSubId = 0;
        [self UpdateOfficeLables];
    }
    //for ( int i = 0; i < arr)
    //[_tblOffice reloadData];
}

-(void)UpdateOfficeLables
{
    if ( arrOffices != nil && arrOffices.count > 0 )
    {
        STOfficeCity *cityInfo = (STOfficeCity *)[arrOffices objectAtIndex:nCity];
        _lblCity.text = cityInfo.name;
        STOfficeCityItem *officeInfo = (STOfficeCityItem*)[cityInfo.offices objectAtIndex:nSubId];
        _lblOffice.text = officeInfo.name;
    }
}
///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call reserve visit service
 */
- (void) callReserveVisit : (NSString *)phone
                      name:(NSString *)name
                        office_id:(long)office_id
                        reserve_time:(NSString*)reserve_time
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] ReserveVisit:phone nick_name:name office_id:office_id reserve_time:reserve_time];
}

- (void) reserveVisitResult:(NSInteger)retcode retmsg:(NSString *)retmsg
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismissWithSuccess:MSG_SUCCESS afterDelay:DEF_DELAY];
		[self performSelector:@selector(onTapBack:) withObject:nil afterDelay:DEF_DELAY];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - User Interaction

- (IBAction)OnChangeDate:(id)sender {
}

- (IBAction)onTapConfirm:(id)sender
{
	// call upload reserve data
	
}

- (IBAction)OnClickBtnCity:(id)sender {
    if ( arrOffices != nil )
    {
        selectType = 0;
        _constraintSelectHeight.constant = (arrOffices.count + 1) * CELL_HEIGHT - 1;
        
        
        _lblHeader.text = @"请选择城市";
        [_tblItems reloadData];
    }
}

- (IBAction)OnClickOfficeID:(id)sender {
    if ( arrOffices != nil )
    {
        selectType = 1;
        
        //if ( arrOffices != nil )
        {
            {
                STOfficeCity *cityInfos = (STOfficeCity *)[arrOffices objectAtIndex:nCity];
                _constraintSelectHeight.constant = (1 + cityInfos.offices.count) * CELL_HEIGHT - 1;
            }
        }
        
        _lblHeader.text = @"请选择办事处";
        
        [_tblItems reloadData];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _vwSelector.hidden = YES;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
{
    return 33;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    nHour = (int)row;
    return _pickerData[row];
}

-(void)setHighlighted:(BOOL)highlighted
{
    // Do original Highlight
    //[super setHighlighted:highlighted];
    
    // Highlight with new colour OR replace with orignial
    if ( highlighted )
    {
        _btnOffice.backgroundColor = [UIColor whiteColor];
        _btnCity.backgroundColor = [UIColor whiteColor];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 11;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( arrOffices != nil )
    {
        if ( selectType == 0 )
        {
            return arrOffices.count;
        }
        else
        {
            STOfficeCity *cityInfos = (STOfficeCity *)[arrOffices objectAtIndex:nCity];
            return cityInfos.offices.count;
        }
    }
    return  0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return _header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* szID = @"cell";
    TableCellForYYCG * cell = [tableView dequeueReusableCellWithIdentifier:szID];

    if ( arrOffices != nil )
    {
        if ( selectType == 0 )
        {
            STOfficeCity *cityInfos = (STOfficeCity *)[arrOffices objectAtIndex:(long)indexPath.row];
            [cell setValue:cityInfos.name :self : (int)indexPath.row];
            
            if ( (int)indexPath.row >= arrOffices.count - 1 )
                _vwSelector.hidden = NO;
        }
        else
        {
            STOfficeCity *cityInfos = (STOfficeCity *)[arrOffices objectAtIndex:nCity];
            STOfficeCityItem *cityItem = (STOfficeCityItem *)[cityInfos.offices objectAtIndex:(long)indexPath.row];
            [cell setValue:cityItem.name:self:(int)indexPath.row];
            
            if ( (int)indexPath.row >= cityInfos.offices.count - 1 )
                _vwSelector.hidden = NO;
        }
    }
    
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _vwSelector.hidden = YES;
    /*
    curMonth = indexPath.row + 1;
    _lblSelector.text = [NSString stringWithFormat:@"%ld月", curMonth];
    
    [self callGetData];
     */
    
}

-  (void) OnClickTblCell:(NSInteger) nIndex
{    _vwSelector.hidden = YES;
    if ( selectType == 0 )
    {
        nCity = (int)nIndex;
        nSubId = 0;
    }
    else
        nSubId = (int)nIndex;
    
    [self UpdateOfficeLables];
}

- (IBAction)OnClickSubmit:(id)sender {
    if ( [Common IsNullOrEmptyString:_txtPhone.text] )
    {
        showToast(@"请输入电话号码。");
        [_txtPhone becomeFirstResponder];
        return;
    }
    
    if ( _txtPhone.text.length != 11 )
    {
        showToast(@"电话号码必须为11立数子。");
        [_txtPhone becomeFirstResponder];
        return;
    }
    
    
    if ( [Common IsNullOrEmptyString:_txtName.text] )
    {
        showToast(@"请输入称呼。");
        [_txtName becomeFirstResponder];
    }
    
    NSDate *oldDate = _datePicker.date; // Or however you get it.
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:oldDate];
    comps.hour   = [_hourPicker selectedRowInComponent:0];
    comps.minute = 0;
    comps.second = 0;
    NSDate *newDate = [calendar dateFromComponents:comps];
    
    NSString *dateString = [GlobalFunc convertDateToString:newDate fmt:nil];
    
    STOfficeCity *cityInfo = (STOfficeCity *)[arrOffices objectAtIndex:nCity];
    _lblCity.text = cityInfo.name;
    STOfficeCityItem *officeInfo = (STOfficeCityItem*)[cityInfo.offices objectAtIndex:nSubId];
    //officeInfo.uid;
    
    [self callReserveVisit:_txtPhone.text name:_txtName.text office_id:officeInfo.uid reserve_time:dateString];
}

@end
