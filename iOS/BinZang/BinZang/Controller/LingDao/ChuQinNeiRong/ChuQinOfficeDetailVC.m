//
//  ChuQinOfficeDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 5/7/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ChuQinOfficeDetailVC.h"

#pragma mark - VocationItemCell

@interface VocationItemCell()

@property (weak, nonatomic) IBOutlet UIView *vwContent;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end

@implementation VocationItemCell

- (void) setData:(STVocation*)vocation index:(long)index
{
	borderWidthColor(_vwContent, 0.5, [UIColor darkGrayColor]);
	_lblNumber.text = [NSString stringWithFormat:@"%ld.", index];
	_lblName.text = [NSString stringWithFormat:@"%@ : %@", vocation.user_desc, vocation.user_name];
	_lblStatus.text = [NSString stringWithFormat:@"休假理由 : %@", vocation.reason_desc];
}

@end

#pragma mark - ChuQinOfficeDetailVC

@interface ChuQinOfficeDetailVC ()
{
	NSString *detail_title;
	NSMutableArray * vocations;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblList;
@end

@implementation ChuQinOfficeDetailVC

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
	self.navigationItem.title = @"出勤状态";
	
	_lblTitle.text = detail_title;
	UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(onTapBack:)];
	
	self.navigationItem.leftBarButtonItem = btnBack;
}

- (void) setDetailInfo : (NSString*)title vocations:(NSMutableArray*)dailyVocations
{
	detail_title = title;
	vocations = dailyVocations;
	
	[_tblList reloadData];
	
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return vocations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cell";
	VocationItemCell *cell = (VocationItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	[cell setData:[vocations objectAtIndex:indexPath.row ] index:indexPath.row + 1];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

@end
