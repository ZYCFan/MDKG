//
//  AppDelegate+BPush.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BPush)
/**
 *  集成百度推送
 *
 *  @param application   应用程序
 *  @param launchOptions 启动项
 */
- (void)integrateBPushNotificationWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions;

@end
