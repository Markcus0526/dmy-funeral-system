//
//  AppDelegate.h
//  BinZang
//
//  Created by KimOkChol on 4/13/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate>
{
    BMKMapManager *             _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

