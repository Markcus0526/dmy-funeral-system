//
//  ZhengQuQuanJingVC.m
//  BinZang
//
//  Created by RyuCholJin on 4/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ZhengQuQuanJingVC.h"
#import "ConstString.h"
#import "KGModal.h"
#import "QuanJingDetailVC.h"
#import "YuYueCanGuanVC.h"

@interface ZhengQuQuanJingVC ()
@property (nonatomic, strong) MRZoomScrollView *myScrollView;
@end


#define SEGUE_TO_DETAIL                     @"segueFromQuanJingToDetail"

@implementation ZhengQuQuanJingVC
{
	NSMutableArray *areaPoints;    
}
@synthesize nViewDidAppear;

- (void)viewDidLoad
{
    nViewDidAppear = 0;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickMessage:)
                                                 name:KGModalViewTapped object: nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( nViewDidAppear > 0 )
        return;
    nViewDidAppear++;
    
   
    [self initControls];
    [self callGetAreaPoints];
    
    return;
}

- (void) initControls
{
    _zoomScrollView = [[MRZoomScrollView alloc] initWithFrame:self.scrollView.bounds];
    
    [self.scrollView addSubview:_zoomScrollView];
    
    _zoomScrollView.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 90, 35);
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(OnReservationVisitor:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"预约参观" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    roundRect(_btnChangeBackground, DEF_CORNER_RADIO);
    borderWidthColor(_btnChangeBackground, 1.f, [UIColor whiteColor]);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _zoomScrollView.viewForZooming;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    //NSLog(@"Zoomscale %f",scale);
    //NSLog(@"Zoom End!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL])
     {
         QuanJingDetailVC * destCtrl = (QuanJingDetailVC *)segue.destinationViewController;
         destCtrl.nUidOfQuanJing = self.nUidOfQuanJing;
         //destCtrl.nUidOfQuanJing =
     }
     
 }


///////////////////////////////////////////////////////////////////////////
#pragma mark - user defined method




///////////////////////////////////////////////////////////////////////////
#pragma mark - Web Service Relation


/**
 * call get Area points
 */
- (void) callGetAreaPoints {
    [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    TEST_NETWORK_RETURN;
    
    [[CommManager getCommMgr] comSvcMgr].delegate = self;
    [[[CommManager getCommMgr] comSvcMgr] GetAreaPoints];
}

- (void) getAreaPointsResult:(NSInteger)retcode retmsg:(NSString *)retmsg datalist:(NSMutableArray *)datalist
{
    if (retcode == SVCERR_SUCCESS) {
        [SVProgressHUD dismiss];
		
		areaPoints = datalist;
        [_zoomScrollView loadAreaPointsView:datalist];
    }
    else
    {
        [SVProgressHUD dismissWithError:retmsg afterDelay:DEF_DELAY];
    }
}

- (void)ClickMessage:(NSNotification *)notification
{
#if 0
//    MyLog(@"ClickMessage : %d", nSelectIndex);
    int index = [[[notification userInfo] valueForKey:@"index"] intValue];
	//STAreaPoint *area = [areaPoints objectAtIndex:index];
	
    long nUid = index;//area.uid;
    MyLog(@"aaaa %ld", nUid);
    self.nUidOfQuanJing = nUid;
    [self performSegueWithIdentifier:SEGUE_TO_DETAIL sender:[NSNumber numberWithLong:nUid]];
#endif
}

- (IBAction)OnReservationVisitor:(id)sender
{
    
    YuYueCanGuanVC *viewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SIDYuYueChangGuan"];
    
    //viewVC.employee_id = _employee_id;
    
    [self.navigationController pushViewController:viewVC animated:YES];
    
}
- (IBAction)OnClickChangeScene:(id)sender {
    [_zoomScrollView changeScene];
}
@end
