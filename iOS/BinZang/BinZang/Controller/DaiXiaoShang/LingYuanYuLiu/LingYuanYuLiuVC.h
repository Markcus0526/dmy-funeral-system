//
//  LingYuanYuLiuVC.h
//  BinZang
//
//  Created by KimOkChol on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LingYuanYuLiuDelegate <NSObject>
-(void) view:(UIViewController*)sender onOK:(id)extra;
-(void) view:(UIViewController*)sender onCancel:(id)extra;
@end

@interface LingYuanYuLiuVC : CustomerSuperViewController

@end
