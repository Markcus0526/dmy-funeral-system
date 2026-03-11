//
//  LingYuanYuLiuNavi.h
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LingYuanYuLiuVC.h"

@interface LingYuanYuLiuNavi : UINavigationController
@property id<LingYuanYuLiuDelegate> lyylDelegate;

-(void) onCancel:(UIViewController*)sender;
-(void) onOK:(UIViewController*)sender;
@end
