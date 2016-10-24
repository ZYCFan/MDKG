//
//  UIViewController+Reachability.h
//  MDKinderGarten
//  To Observer the network and do something when the network  Changed;
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Reachability)
/**
 *  监听网络状态
 */
- (void)addObserverToReachability;
/**
 *  网络状态改变触发事件
 *
 *  @param notification 通知内容
 */
- (void)reachabilityChanged:(NSNotification *)notification;

@end
