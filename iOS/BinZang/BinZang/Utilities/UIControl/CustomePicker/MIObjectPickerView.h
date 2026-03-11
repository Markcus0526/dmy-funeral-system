//
//  MIStringPickerView.h
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerDefine.h"

@interface MINamedObject : NSObject

@property (nonatomic, readwrite) NSString *name;

@end

@interface MIObjectPickerView : UIPickerView <CustomPickerView, UIPickerViewDelegate, UIPickerViewDataSource>

@end
