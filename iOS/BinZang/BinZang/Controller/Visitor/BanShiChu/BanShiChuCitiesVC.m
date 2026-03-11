//
//  BanShiChuCitiesVC.m
//  BinZang
//
//  Created by Beids on 5/15/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BanShiChuCitiesVC.h"
#import "BanShiChuListVC.h"

#define CELL_ID					@"cell"
#define CELL_HEIGHT				70
#define SEGUE_TO_DETAIL			@"segueToBanShiChuList"

@interface BCitiesCell()
{
    BanShiChuCitiesVC *parentVC;
    int nIndex;
}

@end

@implementation BCitiesCell
-(void) setValue : (NSString*)value : (BanShiChuCitiesVC*)pVC : (int) index
{
    [_btnCity setTitle:[NSString stringWithFormat:@"    %@", value]
                 forState:UIControlStateNormal];
    parentVC = pVC;
    nIndex = index;
    _btnCity.tag = index;
    borderWidthColor(_btnCity, 1, [UIColor grayColor]);
}

@end

@interface BanShiChuCitiesVC()
{
    NSMutableArray *arrCities;
    int nSelCity;
}

@end

@implementation BanShiChuCitiesVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
    {
        // get current office data
        UIButton * button = (UIButton *)sender;
        NSMutableArray * datainfo = (NSMutableArray *)((STOfficeCity*)[arrCities objectAtIndex:button.tag]).offices;
        // set data
        BanShiChuListVC * destCtrl = (BanShiChuListVC *)segue.destinationViewController;
        destCtrl.mOfficesInfo = datainfo;
    }
}



///////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Function

- (void) initControls
{
    [self callGetOfficelist];
}

/**
 * update UI
 */
- (void) updateUI : (NSMutableArray *)arrItems
{
    arrCities = arrItems; //STOfficeCity
    [_tblCities reloadData];
}

///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get office list service
 */
- (void) callGetOfficelist
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (arrCities == nil) {
        return 0;
    }
    
    return arrCities.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* szID = CELL_ID;
    BCitiesCell * cell = [tableView dequeueReusableCellWithIdentifier:szID];
    
    if (cell == nil)
    {
        cell = [[BCitiesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szID];
    }
    
    STOfficeCity * cityInfo = (STOfficeCity *)[arrCities objectAtIndex:indexPath.row];
    [cell setValue:cityInfo.name :self : (int)indexPath.row];
    //[cell setValue:cityInfo.name:self:(int)indexPath.row];
    /*
    [cell.imgMain setImageWithURL:[NSURL URLWithUnicodeString:datainfo.image_url] placeholderImage:DEF_IMAGE];
    borderWidthColor(cell.imgMain, 1, [UIColor grayColor]);
    [cell.txtAddress setText:datainfo.address];
    [cell.lblPhone setText:datainfo.phone];
    [cell.btnAddress setTag:indexPath.row];
    [cell.btnPhone setTag:indexPath.row];
    [cell.btnMain setTag:indexPath.row];
    */
    return cell;
}


@end
