//
//  LingYuanYuLiu_Tab2.m
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "LingYuanYuLiu_Tab2.h"
#import "LingYuanYuLiuNavi.h"
#import "MRZoomScrollView.h"
#import "ConstString.h"
#import "KGModal.h"

#define SEGUE_TO_TOMB	@"segueLingYuanYuLiuTomb"
#define SEGUE_TO_STONE	@"segueLingYuanYuLiuStone"


@interface LingYuanYuLiu_Tab2 ()<UIScrollViewDelegate, ComSvcDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;
@property (nonatomic) int nViewDidAppear;


@end

@implementation LingYuanYuLiu_Tab2
{
	NSMutableArray *areaPoints;
}
@synthesize nViewDidAppear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	nViewDidAppear = 0;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickMessage:)
												 name:KGModalViewTapped object: nil];
	
	if (!_tokenData)
		_tokenData = [[NSMutableDictionary alloc] init];


}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	if ( nViewDidAppear > 0 )
		return;
	nViewDidAppear++;
	
    _zoomScrollView = [[MRZoomScrollView alloc] initWithFrame:self.scrollView.bounds];
    
    [self.scrollView addSubview:_zoomScrollView];
    
    _zoomScrollView.delegate = self;
    
  	[self callGetAreaPoints];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _zoomScrollView.viewForZooming;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//if ([segue.identifier isEqualToString:SEGUE_TO_TOMB])
	{
		LingYuanYuLiu_Tab2 *view = segue.destinationViewController;
		if (view && [view respondsToSelector:@selector(setTokenData:)])
		{
			[view setTokenData:_tokenData];
		}
	}
}

- (IBAction)onCancel:(id)sender
{
	LingYuanYuLiuNavi *navigation = (LingYuanYuLiuNavi*)self.navigationController;
	[navigation onCancel:self];
	
}

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
	int index = [[[notification userInfo] valueForKey:@"index"] intValue];
	//STAreaPoint *area = [areaPoints objectAtIndex:index];
	long nUid = index;//area.uid;
    STAreaPoint *area = nil;
    for ( int i = 0; i < areaPoints.count; i++ )
    {
        STAreaPoint *curArea = [areaPoints objectAtIndex:i];
        if ( curArea.uid == nUid )
        {
            area = curArea;
            break;
        }
    }
	//long nUid = area.uid;
	MyLog(@"aaaa %ld", nUid);

    if ( area != nil )
    {
        [_tokenData setObject:[NSNumber numberWithLong:nUid] forKey:@"tomb_area_id"];
		
        [_tokenData setObject:[NSNumber numberWithLong:area.row_count] forKey:@"row_count"];
        [_tokenData setObject:[NSNumber numberWithLong:area.column_count] forKey:@"column_count"];
    }
	
	if (area.type)
		[self performSegueWithIdentifier:SEGUE_TO_STONE sender:_tokenData];
	else
		[self performSegueWithIdentifier:SEGUE_TO_TOMB sender:_tokenData];
}


- (IBAction)onTapChangeBackground:(id)sender
{
}
@end
