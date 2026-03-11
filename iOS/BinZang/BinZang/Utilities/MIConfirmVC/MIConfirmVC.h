//
//  MIConfirmVC.h
//  BinZang
//
//  Created by KimOkChol on 5/12/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MIConfirmDelegate <NSObject>

- (void) onConfirmOK;
- (void) onConfirmCacel;
@end
@interface MIConfirmVC : UIViewController
@property (nonatomic, readwrite) id<MIConfirmDelegate> delegate;

-(void) setMessage:(NSString*)message;

@end
