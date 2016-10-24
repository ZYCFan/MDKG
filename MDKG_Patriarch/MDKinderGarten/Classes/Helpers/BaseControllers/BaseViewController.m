//
//  BaseViewController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 显示等待框
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode {
    [self.view showHUDIndicatorViewAtCenter:message mode:mode];
}

- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay {
    [self.view showHUDIndicatorViewAtCenter:message mode:mode afterDelay:delay];
}

- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay completionBlock:(void (^)())success {
    [self.view showHUDIndicatorViewAtCenter:message mode:mode afterDelay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success();
    });
}

- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset {
    [self.view showHUDIndicatorViewAtCenter:message mode:mode yOffset:yOffset];
}

- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset afterDelay:(NSTimeInterval)delay {
    [self.view showHUDIndicatorViewAtCenter:message mode:mode yOffset:yOffset afterDelay:delay];
}

- (void)removeActivityIndicatorView {
    [self.view hideHUDIndicatorViewAtCenter];
}


@end
