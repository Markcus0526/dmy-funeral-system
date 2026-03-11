//
//  BinZangOneDragonDetailVC.m
//  BinZang
//
//  Created by KimOkChol on 4/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "BinZangOneDragonDetailVC.h"

@interface BinZangOneDragonDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgThings;
@property (weak, nonatomic) IBOutlet UILabel *comp_name;
@property (weak, nonatomic) IBOutlet UILabel *suit_price;
@property (weak, nonatomic) IBOutlet UILabel *comp_intro;
@property (weak, nonatomic) IBOutlet UILabel *suit_intro;
@property (weak, nonatomic) IBOutlet UILabel *service_content;

@end

@implementation BinZangOneDragonDetailVC

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

- (void) initControls
{
	[self callGetService];
}

- (void) updateUI:(STDragonService*)service
{
	if (!service)
		return;
	
	[_imgThings setImageWithURL:[NSURL URLWithString:service.image_url] placeholderImage:DEF_IMAGE];
	
	_comp_intro.text = service.intro;
	_suit_price.text = service.price_desc;
	_comp_name.text = service.name;
	_suit_intro.text = service.product_intro;
	_service_content.text = service.service_contents;
	
}
///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

/**
 * call get service area list service
 */
- (void) callGetService
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetOneDragonCompDetail:self.nServiceId];
}

- (void) getOneDragonCompDetResult	: (NSInteger)retcode retmsg:(NSString *)retmsg datainfo:(STDragonService *)datainfo
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		
		[self updateUI:datainfo];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}


@end
