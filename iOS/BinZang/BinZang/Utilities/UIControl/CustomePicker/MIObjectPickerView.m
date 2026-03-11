//
//  MIStringPickerView.m
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIObjectPickerView.h"

#define CELL_HEIGHT 33

@implementation MINamedObject
@end

@implementation MIObjectPickerView
{
    NSMutableArray *mValues;
}
@synthesize pickerDelegate;

- (id) init
{
    self = [super init];
    self.dataSource = self;
    self.delegate = self;
    
    return self;
}

- (void) setValues : (NSMutableArray*)values
{
    mValues = values;
    [self selectRow:0 inComponent:0 animated:YES];
    [self reloadAllComponents];
}

- (NSString*) getValue
{
    int idx = [self selectedRowInComponent:0];
    if (!mValues || [mValues count] <= 0 || idx < 0 || idx >= [mValues count])
        return nil;
    
    MINamedObject *object = [mValues objectAtIndex:idx];
    
    return [object name];
}

- (void) setValue : (NSString*)value
{
    if (!value || !stringNotNilOrEmpty(value))
        return;
    
    for (int i = 0; i < [mValues count]; i++) {
        MINamedObject *object = [mValues objectAtIndex:i];
        if ([value isEqualToString:[object name]])
            [self selectRow:i inComponent:0 animated:YES];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerDelegate valueChanged:row value:[self getValue]];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mValues count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return CELL_HEIGHT;
}

// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    MINamedObject *object = [mValues objectAtIndex:row];
    return [object name];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
