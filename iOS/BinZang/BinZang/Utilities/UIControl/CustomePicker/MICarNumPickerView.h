//
//  CarNumberPicker.h
//  FSManager
//
//  Created by ChoeMI on 2/20/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerDefine.h"

@interface MICarNumberPickerView : UIPickerView <CustomPickerView, UIPickerViewDelegate, UIPickerViewDataSource>


+ (NSArray *)getCarProvinceArray;
+ (NSArray *)getCarCityArray;
+ (NSArray *)getCarNumberArray;

@end
