//
//  AppDelegate+UMeng.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "AppDelegate+UMeng.h"

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
NSString *const kUMengKey = @"56c13f4f67e58ed3790011c7";

@implementation AppDelegate (UMeng)

- (void)integrateUMengWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    [MobClick setLogEnabled:YES];//release版本要注释掉此行
    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithAppkey:kUMengKey reportPolicy:BATCH channelId:nil];
}

@end
