//
//  ShengHuoKaoShiVC.m
//  BinZang
//
//  Created by KimOkChol on 4/18/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoKaoShiVC.h"
#import "UIImageView+AFNetworking.h"

@interface ShengHuoKaoShiVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgGongWuYuan;
@property (weak, nonatomic) IBOutlet UIImageView *imgXueJiao;
@property (weak, nonatomic) IBOutlet UIImageView *imgZhengZhao;
@property (weak, nonatomic) IBOutlet UIButton *btnGongWuYuan;
@property (weak, nonatomic) IBOutlet UIButton *btnXueJiao;
@property (weak, nonatomic) IBOutlet UIButton *btnZhengZhao;
@end

@implementation ShengHuoKaoShiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUI : (NSString *)worker_img_url school_img_url:(NSString *)school_img_url photo_img_url:(NSString *)photo_img_url
{
	[_imgGongWuYuan setImageWithURL:[NSURL URLWithUnicodeString:worker_img_url] placeholderImage:DEF_IMAGE];
	[_imgXueJiao setImageWithURL:[NSURL URLWithUnicodeString:school_img_url] placeholderImage:DEF_IMAGE];
	[_imgZhengZhao setImageWithURL:[NSURL URLWithUnicodeString:photo_img_url] placeholderImage:DEF_IMAGE];
}

- (void) initControls
{
	[self onTapGongWuYuan:nil];
	[self callGetUrl];
}
///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation

- (void) callGetUrl
{
	[SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
	
	TEST_NETWORK_RETURN;
	
	[[CommManager getCommMgr] comSvcMgr].delegate = self;
	[[[CommManager getCommMgr] comSvcMgr] GetExamImageUrl];
}

- (void) getExamImageUrlResult		: (NSInteger)retcode retmsg:(NSString *)retmsg worker_img_url:(NSString *)worker_img_url school_img_url:(NSString *)school_img_url photo_img_url:(NSString *)photo_img_url
{
	if (retcode == SVCERR_SUCCESS)
	{
		[SVProgressHUD dismiss];
		[self updateUI:worker_img_url school_img_url:school_img_url photo_img_url:photo_img_url];
	}
	else
	{
		[SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onTapGongWuYuan:(id)sender
{
	_btnGongWuYuan.selected = YES;
	_imgGongWuYuan.hidden = NO;
	_btnXueJiao.selected = NO;
	_imgXueJiao.hidden = YES;
	_btnZhengZhao.selected = NO;
	_imgZhengZhao.hidden = YES;
}

- (IBAction)onTapXueJiao:(id)sender
{
	_btnGongWuYuan.selected = NO;
	_imgGongWuYuan.hidden = YES;
	_btnXueJiao.selected = YES;
	_imgXueJiao.hidden = NO;
	_btnZhengZhao.selected = NO;
	_imgZhengZhao.hidden = YES;
}

- (IBAction)onTapZhengZhao:(id)sender
{
	_btnGongWuYuan.selected = NO;
	_imgGongWuYuan.hidden = YES;
	_btnXueJiao.selected = NO;
	_imgXueJiao.hidden = YES;
	_btnZhengZhao.selected = YES;
	_imgZhengZhao.hidden = NO;
}
@end
