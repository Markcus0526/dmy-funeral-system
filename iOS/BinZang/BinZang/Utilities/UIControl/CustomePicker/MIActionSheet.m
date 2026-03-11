//
//  CarNumberActionSheet.m
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIActionSheet.h"
#import "MICarNumPickerView.h"

#define BUTTON_WIDTH	90
#define BUTTON_HEIGHT	40
#define HORIZONTAL_GAP 	20
#define VERTICAL_GAP	6

#define TITLEBAR_HEIGHT			BUTTON_HEIGHT + VERTICAL_GAP + VERTICAL_GAP

#define ACTIONVIEW_HEIGHT		PICKER_VIEW_HEIGHT + TITLEBAR_HEIGHT

#define COLOR_TEXT          [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define COLOR_BACKGROUND    [UIColor whiteColor]

@implementation MIActionSheet
{
    UIView*                         view;
	UIView*							titleView;
    UILabel *                       strCaption;
    UIPickerView<CustomPickerView>* picker;
}

@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init
{
	int button_width = BUTTON_WIDTH;
	int button_height = BUTTON_HEIGHT;
	int horizontal_gap = HORIZONTAL_GAP;
	int vertical_gap = VERTICAL_GAP;
	
    self = [super init];
	CGRect wndFrame = [[UIScreen mainScreen] applicationFrame];
	long nWidth = wndFrame.size.width;
	
	int titleBar_height = button_height + vertical_gap * 2;
	
    strCaption = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nWidth, titleBar_height)];
    [strCaption setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, nWidth, titleBar_height)];
    //    [imgView setBackgroundColor:[UIColor clearColor]];
    [imgView setImage:[UIImage imageNamed:@"title_bar.png"]];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(horizontal_gap, vertical_gap, button_width, button_height)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCanceled:) forControlEvents:UIControlEventTouchUpInside];
    roundRect(cancelBtn, DEF_CORNER_RADIO);
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(nWidth - button_width - horizontal_gap, vertical_gap, button_width, button_height)];
	
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor whiteColor]];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(onSelected:) forControlEvents:UIControlEventTouchUpInside];
    roundRect(okBtn, DEF_CORNER_RADIO);
    
	titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nWidth, TITLEBAR_HEIGHT)];
	
    [titleView addSubview:imgView];
    [titleView addSubview:strCaption];
    [titleView addSubview:cancelBtn];
    [titleView addSubview:okBtn];
    
    return self;
}

- (void) setPickerValue : (UIPickerView<CustomPickerView>*)_picker value : (NSString*) value
{
    picker = _picker;
	CGRect wndFrame = [[UIScreen mainScreen] applicationFrame];
	long nWidth = wndFrame.size.width;
	CGSize sizePicker = picker.frame.size;
	
    [picker setFrame:CGRectMake(0, TITLEBAR_HEIGHT, sizePicker.width, sizePicker.height)];
    
//    picker.showsSelectionIndicator = YES;
    picker.backgroundColor = [UIColor whiteColor];

    picker.pickerDelegate = self;
//    [picker initWithValues:nil];
    [picker setValue:value];

	view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nWidth, TITLEBAR_HEIGHT + sizePicker.height + 20)];
	view.backgroundColor = [UIColor clearColor];
	

	[view addSubview:titleView];
	[view addSubview:picker];
	
    [strCaption setText:[picker getValue]];
}

- (void) showActionSheet
{
    [self actionSheetSimulationWithPickerView:view];
}

- (void) setValue : (NSString*) value
{
    if (!picker) return ;
    
    [picker setValue : value];
    [strCaption setText : value];
}

#pragma mark - PickerSelectedDelegate
- (void) valueChanged : (long) index value:(NSString*)value
{
    [strCaption setText:value];
}

#pragma mark - Event Handler

- (void) onSelected : (id)sender
{
    long index = 0;
    if ([picker isKindOfClass:[MIObjectPickerView class]] || [picker isKindOfClass:[MIStringPickerView class]])
        index = [picker selectedRowInComponent:0];
    
    if (![picker getValue])
        return;
    [delegate okSelector:index value:[picker getValue]];
    [self dismissActionSheetSimulation];
}

- (void) onCanceled : (id)sender
{
    //[delegate cancelSelector];
    [self dismissActionSheetSimulation];
}


@end
