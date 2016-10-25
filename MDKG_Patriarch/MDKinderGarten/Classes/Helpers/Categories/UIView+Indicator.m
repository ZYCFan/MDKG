//
//  UIView+Indicator.m
//  GTP2P
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UIView+Indicator.h"

#define hudViewTag                     0x98751235
@implementation UIView (Indicator)

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    
    if (hud == nil){
        
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:0];
    }else{
        hud.label.text = indiTitle;
    }
    hud.mode = mode;
    [hud showAnimated:YES];
}

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:0];
    } else {
        hud.label.text = indiTitle;
    }
    hud.mode = mode;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    
    if (hud == nil){
        
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:y];
        
    }else{
        hud.label.text = indiTitle;
    }
    hud.mode = mode;
    [hud showAnimated:YES];
}

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode yOffset:(CGFloat)y afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (!hud) {
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:y];
    } else {
        hud.label.text = indiTitle;
    }
    hud.mode = mode;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)hideHUDIndicatorViewAtCenter
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    
    [hud hideAnimated:YES];
}

- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.layer.zPosition = 10;
    hud.offset = CGPointMake(hud.offset.x, y);
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = indiTitle;
    [self addSubview:hud];
    hud.tag = hudViewTag;
    return hud;
}

- (MBProgressHUD *)getHUDIndicatorViewAtCenter
{
    UIView *view = [self viewWithTagNotDeepCounting:hudViewTag];
    
    if (view != nil && [view isKindOfClass:[MBProgressHUD class]]){
        
        return (MBProgressHUD *)view;
    }
    else
    {
        return nil;
    }
}

- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}

@end
