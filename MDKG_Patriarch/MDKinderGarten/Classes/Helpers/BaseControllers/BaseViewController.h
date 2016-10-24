//
//  BaseViewController.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  在视图中间显示消息
 *
 *  @param message 消息内容
 */
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode;
/**
 *  在视图中间置显示消息
 *
 *  @param message 消息内容
 *  @param delay   延迟消失时间
 */
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay;
/**
 *  在视图中间显示消息
 *
 *  @param message 消息内容
 *  @param delay   延迟消失时间
 *  @param success 消失以后执行代码
 */
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay completionBlock:(void(^)())success;
/**
 *  在指定偏移位置显示消息
 *
 *  @param message 消息内容
 *  @param yOffset 偏移量
 */
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset;
/**
 *  在指定偏移位置显示消息
 *
 *  @param message 消失内容
 *  @param yOffset 偏移量
 *  @param delay   延迟消失时间
 */
- (void)displayActivityIndicatorView:(NSString *)message mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset afterDelay:(NSTimeInterval)delay;
/**
 *  移除消息视图
 */
- (void)removeActivityIndicatorView;

@end
