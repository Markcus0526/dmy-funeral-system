//
//  BanShiChuDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BanShiChuDetailVC.h"

@interface OfficeEmpTableCell()
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblQQ;
@property (weak, nonatomic) IBOutlet UILabel *lblWechat;

@end
@implementation OfficeEmpTableCell
{
	STOfficeEmp * employee;
}
- (void) setData:(STOfficeEmp*)empInfo
{
	if ( empInfo == nil )
		return;

	employee = empInfo;
	
	[_lblDesc setText:empInfo.desc];
	
//	borderWidthColor(_imgMain, 1, [UIColor grayColor]);
	
	if ( empInfo.photo_url != nil )
		[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:empInfo.photo_url] placeholderImage:DEF_IMAGE];
	
	[_lblName setText:[NSString stringWithFormat:@"名称 : %@", empInfo.name]];
	[_lblQQ setText:[NSString stringWithFormat:@"QQ : %@", empInfo.qq]];
	[_lblWechat setText:[NSString stringWithFormat:@"微信 : %@", empInfo.wechat]];
	
	NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
	_lblTel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Tel : %@", empInfo.phone] attributes:underlineAttribute];
	
	_lblTel.userInteractionEnabled = YES;
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callByPhone)];
	[_lblTel addGestureRecognizer:tapGesture];
}

- (void) callByPhone
{
	[GlobalFunc callPhone:employee.phone];
}
@end


@interface BanShiChuDetailVC ()

@property (weak, nonatomic) IBOutlet UITableView *tblEmployee;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UIView *vwInfo;


@end


#define CELL_ID						@"cellOfficeEmp"
#define CELL_HEIGHT					150

@implementation BanShiChuDetailVC

@synthesize mOfficeInfo;
@synthesize mOfficeUid;

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

- (void) viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	// Force your tableview margins (this may be a bad idea)
//	if ([_tblEmployee respondsToSelector:@selector(setSeparatorInset:)]) {
//		[_tblEmployee setSeparatorInset:UIEdgeInsetsZero];
//	}
//	if ([_tblEmployee respondsToSelector:@selector(setLayoutMargins:)]) {
//		[_tblEmployee setLayoutMargins:UIEdgeInsetsZero];
//	}
	
}

- (void) initControls
{
	borderWidthColor(_imgMain, 1, [UIColor grayColor]);
	
	[self callGetOfficeDetail];
}

- (void) updateUI
{
	[_imgMain setImageWithURL:[NSURL URLWithUnicodeString:mOfficeInfo.image_url] placeholderImage:DEF_IMAGE];
	[_lblAddress setText:mOfficeInfo.address];
	
	NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
	_lblPhone.attributedText = [[NSAttributedString alloc] initWithString:mOfficeInfo.phone attributes:underlineAttribute];
	
	CGRect frame = _vwInfo.frame;
	
	frame.size.height = _imgMain.frame.size.height + 70;
	
	_vwInfo.frame = frame;

	[_tblEmployee layoutMarginsDidChange];
	[_tblEmployee reloadData];
	
}

- (IBAction)onTapOfficeCall:(id)sender
{
	[GlobalFunc callPhone:mOfficeInfo.phone];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get office detail info service
 */
- (void) callGetOfficeDetail
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOfficeDetail : mOfficeUid];
}

- (void) getOfficeDetailResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STOffice *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		mOfficeInfo = datainfo;
		[self updateUI];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

#pragma mark - Table view data source

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Remove seperator inset
	if ([cell respondsToSelector:@selector(setSeparatorInset:)])
	{
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	// Prevent the cell from inheriting the Table view's margin settings
	if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
	{
		[cell setPreservesSuperviewLayoutMargins:NO];
	}
	
	// Explictly set your cell's layout margins
	if ([cell respondsToSelector:@selector(setLayoutMargins:)])
	{
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if (mOfficeInfo.employees == nil) {
		return 0;
	}
	
	return mOfficeInfo.employees.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
		return CELL_HEIGHT + _tblEmployee.frame.size.width / 2 - 160;
	else
		return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* szID = CELL_ID;
	OfficeEmpTableCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
	
	if (cell == nil)
	{
		cell = [[OfficeEmpTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
	}
	
	STOfficeEmp * datainfo = (STOfficeEmp *)[mOfficeInfo.employees objectAtIndex:indexPath.row];
    
	[cell setData:datainfo];
	return cell;
}

@end
