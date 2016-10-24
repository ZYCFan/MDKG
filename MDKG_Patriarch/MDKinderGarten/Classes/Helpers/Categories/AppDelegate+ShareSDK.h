//
//  AppDelegate+ShareSDK.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ShareSDK)
/**
 *  集成分享
 *
 *  @param application 应用程序
 *  @param options     启动项
 */
- (void)integrateShareSDKWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)options;

@end
