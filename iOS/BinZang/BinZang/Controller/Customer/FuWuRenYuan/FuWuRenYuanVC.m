//
//  FuWuRenYuanVC.m
//  BinZang
//
//  Created by Admin on 4/23/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "FuWuRenYuanVC.h"

@interface FuWuRenYuanVC ()
@property (weak, nonatomic) IBOutlet UIView *vwDetail;

@end

@implementation FuWuRenYuanVC

@synthesize mManInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self callGetServicePeopleInfo];
    [self initControls];
}

- (void)initControls {
    self.mNameLabel.text = @"";
    self.mJobLabel.text = @"";
    self.mOfficeLabel.text = @"";
    self.mPhoneLabel.text = @"";
    self.mAddressLabel.text = @"";
	
	int user_type = [Common userInfo].user_type;
	
	if (user_type == UserType_JiuKeHu)
		_vwDetail.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callGetServicePeopleInfo
{
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetSvcPeopleInfo];
}

- (void)getSvcPeopleInfoResult:(NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STOfficeEmp*)datainfo
{
    if (retcode == SVCERR_SUCCESS)
    {
        [SVProgressHUD dismiss];
        
        mManInfo = datainfo;
        [self updateUI];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}

- (void) updateUI
{
    self.mNameLabel.text = mManInfo.name;
    self.mJobLabel.text = mManInfo.desc;
    self.mOfficeLabel.text = mManInfo.office;
    self.mPhoneLabel.text = mManInfo.phone;
    self.mAddressLabel.text = mManInfo.address;
    
    [self.mImageView setImageWithURL:[NSURL URLWithUnicodeString:mManInfo.photo_url] placeholderImage:DEF_IMAGE];
    
    self.mImageView.layer.borderWidth = 1;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClickPhoneNumber:(id)sender {
    if ( mManInfo.phone != nil )
    [GlobalFunc callPhone:mManInfo.phone];
}

- (IBAction)ClickMingXiBiao:(id)sender
{
}

@end
