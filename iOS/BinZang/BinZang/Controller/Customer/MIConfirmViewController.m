//
//  MIConfirmViewController.m
//  BinZang
//
//  Created by KimOkChol on 5/12/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIConfirmViewController.h"

@interface MIConfirmViewController ()

@property (weak, nonatomic) IBOutlet UIView *vwContent;
@property (weak, nonatomic) IBOutlet UILabel *TitleBox;
@property (weak, nonatomic) IBOutlet UIButton *btnConfOK;
@property (weak, nonatomic) IBOutlet UIButton *btnConfCancel;
@end

@implementation MIConfirmViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:@"MIConfirmVC" bundle:nil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self onConfCancel:self];
}


- (void) initControls
{
	[self.view setBackgroundColor:[UIColor clearColor]];
	roundRect(_vwContent, DEF_CORNER_RADIO);
	roundRect(_btnConfOK, DEF_CORNER_RADIO);
	roundRect(_btnConfCancel, DEF_CORNER_RADIO);
	borderWidthColor(_btnConfCancel, 0.5, [UIColor darkGrayColor]);
	
}

- (void) setMessage:(NSString *)message
{
	_TitleBox.text = message;
}

- (IBAction)onConfOK:(id)sender
{
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
	[_delegate onConfirmOK];
}

- (IBAction)onConfCancel:(id)sender
{
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
	[_delegate onConfirmCancel];
}
@end
