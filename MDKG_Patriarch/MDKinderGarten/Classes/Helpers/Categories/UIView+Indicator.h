//
//  UIView+Indicator.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (Indicator)

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode;
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay;
- (void)hideHUDIndicatorViewAtCenter;
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode yOffset:(CGFloat)y;
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle mode:(MBProgressHUDMode)mode yOffset:(CGFloat)y afterDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)getHUDIndicatorViewAtCenter;

- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag;

@end
