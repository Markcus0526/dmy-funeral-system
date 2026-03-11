//
//  CarNumberPicker.m
//  FSManager
//
//  Created by ChoeMI on 2/20/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MICarNumPickerView.h"

#define CELL_HEIGHT     33

#define CARNUMBER_LENGTH       7

#define ALLOW_SPLIT				0
//#define ALLOW_SPLIT				1

@implementation MICarNumberPickerView


@synthesize pickerDelegate;

NSArray* numberArray[CARNUMBER_LENGTH];


+ (NSArray *)getCarProvinceArray
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"京", @"津", @"冀", @"晋", @"蒙", @"辽", @"吉", @"黑", @"沪", @"苏", @"浙", @"皖", @"闽", @"赣", @"鲁", @"豫", @"鄂", @"湘", @"粤", @"桂", @"琼", @"渝", @"川", @"贵", @"云", @"藏", @"陕", @"甘", @"青", @"宁", @"新", @"台", @"4", nil];
    return  array;
}

+ (NSArray *)getCarCityArray
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"A", @"B",@"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    return  array;
}

+ (NSArray *)getCarNumberArray
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B",@"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    return  array;
}

- (void) initValues{
    numberArray[0] = [MICarNumberPickerView getCarProvinceArray];
    numberArray[1] = [MICarNumberPickerView getCarCityArray];
    for (int i = 2; i < CARNUMBER_LENGTH; i++) {
        numberArray[i] = [MICarNumberPickerView getCarNumberArray];
    }
}

- (id) init
{
    self = [super init];
    
    self.dataSource = self;
    self.delegate = self;
    
    [self initValues];
    return self;
}

- (void) setValues : (NSMutableArray*)values
{}

- (NSString*) getValue
{
    NSMutableString *carNum = [NSMutableString string];
    
    long idx = 0;
    for (int i = 0; i < CARNUMBER_LENGTH; i++) {
        idx = [self selectedRowInComponent:i];
		if (ALLOW_SPLIT == 1)
		{
			if (i == 1)
				[carNum appendFormat:@"%@-", [numberArray[1] objectAtIndex:idx]];
			else
				[carNum appendFormat:@"%@", [numberArray[i] objectAtIndex:idx]];
		}
		else
		{
			[carNum appendFormat:@"%@", [numberArray[i] objectAtIndex:idx]];
		}
    }
    return carNum;
}

- (void) setValue : (NSString*)value
{
    if (!value || !stringNotNilOrEmpty(value))
        return;
    
    if (value.length > 0) {
        NSString *carNum = value;
        carNum = [carNum uppercaseString];
        
        unichar num = [carNum characterAtIndex:0];
        if (num > 'Z' || num == '4') { // province name or travel user
            NSArray *numTempArray = numberArray[0];
            int comIdx = 0;
            int offset = 0;
            
            for (int i = 0; i < carNum.length; i++) {
                num = [carNum characterAtIndex:i];
                
                if (num == '-') {
                    offset += 1;
                    continue;
                }
                
                if (i == 0) {
                    for (int j = 0; j < numTempArray.count; j++) {
                        NSString *numT = [numTempArray objectAtIndex:j];
                        unichar num2 = [numT characterAtIndex:0];
                        
                        if (num == num2) {
                            [self selectRow:j inComponent:comIdx animated :YES];
                            break;
                        }
                    }
                    numTempArray = numberArray[1];
                    comIdx = 1;
                }
                else if (i < offset + 7) {
                    for (int j = 0; j < numTempArray.count; j++) {
                        NSString *numT = [numTempArray objectAtIndex:j];
                        unichar num2 = [numT characterAtIndex:0];
                        
                        if (num == num2) {
                            [self selectRow:j inComponent:comIdx animated :YES];
                            break;
                        }
                    }
                    
                    if (comIdx == 1) {
                        numTempArray = numberArray[2];
                        comIdx = 2;
                    }
                    else if (comIdx == 2) {
                        numTempArray = numberArray[3];
                        comIdx = 3;
                    }
                    else if (comIdx == 3) {
                        numTempArray = numberArray[4];
                        comIdx = 4;
                    }
                    else if (comIdx == 4) {
                        numTempArray = numberArray[5];
                        comIdx = 5;
                    }
                    else if (comIdx == 5) {
                        numTempArray = numberArray[6];
                        comIdx = 6;
                    }
                }
                else {
                    break;
                }
            }
        }
        else {
            NSArray *numTempArray = numberArray[0];
            int comIdx = 0;
            int offset = 0;
            
            for (int i = 0; i < carNum.length; i++) {
                num = [carNum characterAtIndex:i];
                
                if (num == '-') {
                    offset += 1;
                    continue;
                }
                numTempArray = numberArray[1];
                comIdx = 1;
                
                if (i < 6) {
                    for (int j = 0; j < numTempArray.count; j++) {
                        NSString *numT = [numTempArray objectAtIndex:j];
                        unichar num2 = [numT characterAtIndex:0];
                        
                        if (num == num2) {
                            [self selectRow:j inComponent:comIdx animated :YES];
                            break;
                        }
                    }
                    
                    if (comIdx == 1) {
                        numTempArray = numberArray[2];
                        comIdx = 2;
                    }
                    else if (comIdx == 2) {
                        numTempArray = numberArray[3];
                        comIdx = 3;
                    }
                    else if (comIdx == 3) {
                        numTempArray = numberArray[4];
                        comIdx = 4;
                    }
                    else if (comIdx == 4) {
                        numTempArray = numberArray[5];
                        comIdx = 5;
                    }
                    else if (comIdx == 5) {
                        numTempArray = numberArray[6];
                        comIdx = 6;
                    }
                }
                else {
                    break;
                }
            }
        }
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerDelegate valueChanged:row value:[self getValue]];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [numberArray[component] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return CARNUMBER_LENGTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return CELL_HEIGHT;
}

// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [numberArray[component] objectAtIndex:row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
