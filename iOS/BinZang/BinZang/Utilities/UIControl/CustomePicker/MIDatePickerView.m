//
//  MIDatePickerView.m
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIDatePickerView.h"
#import "NSDate+String.h"

#define CELL_HEIGHT 33

@implementation MIDatePickerView

@synthesize pickerDelegate;

- (id) init
{
    self = [super init];

    [self setDatePickerMode:UIDatePickerModeDateAndTime];
    
    [self removeTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(updateDate:) forControlEvents:UIControlEventValueChanged];

    return self;
}

- (void) setValues : (NSMutableArray*)values
{}

- (void) initWithValues : (NSMutableArray*)values
{
}

- (void) updateDate : (id)sender
{
    [pickerDelegate valueChanged:0 value:[self getValue]];
}

- (NSString*) getValue
{
    NSDate *date = [self date];

    NSString *format = @"yyyy-MM-dd HH:mm";
    
    return [date toStringWithFormat:format];
}

- (void) setValue : (NSString*)value
{
    if (!value || !stringNotNilOrEmpty(value))
        return;
    
    NSString *format = @"yyyy-MM-dd HH:mm";
    NSDate *date = [NSDate dateWithString:value withFormat:format];
    if (date) [self setDate:date];
}

@end
