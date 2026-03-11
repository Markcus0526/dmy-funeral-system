//
//  ShengHuoFuWuMainVC.m
//  BinZang
//
//  Created by KimOkChol on 4/17/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "ShengHuoFuWuMainVC.h"

@interface ShengHuoFuWuMainVC ()

@end

@implementation ShengHuoFuWuMainVC

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
	UIColor * color = [UIColor greenColor];
	borderWidthColor(_vwFood, 1, color);
	borderWidthColor(_vwHotel, 1, color);
	borderWidthColor(_vwCinema, 1, color);
	borderWidthColor(_vwResort, 1, color);
}

@end
