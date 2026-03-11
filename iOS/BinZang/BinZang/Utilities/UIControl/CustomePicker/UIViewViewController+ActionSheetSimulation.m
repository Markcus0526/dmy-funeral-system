//
//  UIViewViewController+ActionSheetSimulation.m
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "UIViewViewController+ActionSheetSimulation.h"


@implementation UIViewController (ActionSheetSimulation)

UIView* simulatedActionSheetView;


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissActionSheetSimulation];
}

-(UIView *)actionSheetSimulationWithPickerView:(UIPickerView *)pickerView withToolbar:(UIToolbar *)pickerToolbar {
    
    simulatedActionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                            UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [simulatedActionSheetView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat pickerViewYpositionHidden = UIScreen.mainScreen.bounds.size.height + pickerToolbar.frame.size.height;
    CGFloat pickerViewYposition = UIScreen.mainScreen.bounds.size.height -
    pickerView.frame.size.height +
    UIApplication.sharedApplication.statusBarFrame.size.height;
    
    [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                    pickerViewYpositionHidden,
                                    pickerView.frame.size.width,
                                    pickerView.frame.size.height)];
    
    [pickerToolbar setFrame:CGRectMake(pickerToolbar.frame.origin.x,
                                       pickerViewYpositionHidden - pickerToolbar.frame.size.height,
                                       pickerToolbar.frame.size.width,
                                       pickerToolbar.frame.size.height)];
    
    pickerView.backgroundColor = [UIColor whiteColor];
    [simulatedActionSheetView addSubview:pickerToolbar];
    [simulatedActionSheetView addSubview:pickerView];
    
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0]
                                                                              addSubview:simulatedActionSheetView];
    [simulatedActionSheetView.superview bringSubviewToFront:simulatedActionSheetView];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [simulatedActionSheetView setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
                         [self.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [self.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                                         pickerViewYposition,
                                                         pickerView.frame.size.width,
                                                         pickerView.frame.size.height)];
                         [pickerToolbar setFrame:CGRectMake(pickerToolbar.frame.origin.x,
                                                            pickerViewYposition - pickerToolbar.frame.size.height,
                                                            pickerToolbar.frame.size.width,
                                                            pickerToolbar.frame.size.height)];
                     }
                     completion:nil];
    
    return simulatedActionSheetView;
}

-(UIView*) actionSheetSimulationWithPickerView:(UIView*)view
{
    
    simulatedActionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                        UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [simulatedActionSheetView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat viewYpositionHidden = UIScreen.mainScreen.bounds.size.height;
    CGFloat viewYposition = UIScreen.mainScreen.bounds.size.height - view.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height;
    
    [view setFrame:CGRectMake(view.frame.origin.x,
                                    viewYpositionHidden,
                                    view.frame.size.width,
                                    view.frame.size.height)];
    
    [simulatedActionSheetView addSubview:view];
    
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0]
                                                                              addSubview:simulatedActionSheetView];
    [simulatedActionSheetView.superview bringSubviewToFront:simulatedActionSheetView];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [simulatedActionSheetView setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
                         [self.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [self.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [view setFrame:CGRectMake(view.frame.origin.x,
                                                         viewYposition,
                                                         view.frame.size.width,
                                                         view.frame.size.height)];

                     }
                     completion:nil];
    
    return simulatedActionSheetView;
}

-(void)dismissActionSheetSimulation
{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [simulatedActionSheetView setBackgroundColor:[UIColor clearColor]];
                         [self.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [self.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [simulatedActionSheetView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             UIView* v = (UIView*)obj;
                             [v setFrame:CGRectMake(v.frame.origin.x,
                                                    UIScreen.mainScreen.bounds.size.height,
                                                    v.frame.size.width,
                                                    v.frame.size.height)];
                         }];
                     }
                     completion:^(BOOL finished) {
                         [simulatedActionSheetView removeFromSuperview];
                     }];
    
}

@end