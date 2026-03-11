//
//  CustomPickerDefine.h
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#ifndef FSManager_CustomPickerDefine_h
#define FSManager_CustomPickerDefine_h

@protocol MISelectorDelegate

- (void) okSelector : (long)index value: (NSString*)value;
@optional
- (void) cancelSelector;

@end

@protocol MIPickerDelegate

- (void) valueChanged : (long) index value:(NSString*)value;

@end

@protocol CustomPickerView

@property (nonatomic, readwrite) id<MIPickerDelegate> pickerDelegate;

- (void) setValues : (NSMutableArray*)values;
- (void) setValue : (NSString*)value;
- (NSString*) getValue;

@end


#endif
