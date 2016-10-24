//
//  UIViewController+Reachability.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UIViewController+Reachability.h"

@implementation UIViewController (Reachability)

- (void)addObserverToReachability {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    NSDictionary *networkStatus = notification.userInfo;
    AFNetworkReachabilityStatus status = [[networkStatus valueForKey:AFNetworkingReachabilityNotificationStatusItem] integerValue];
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
        {
            NSLog(@"未知网络");
        }
            break;
        case AFNetworkReachabilityStatusNotReachable:
        {
            NSLog(@"链接错误");
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            NSLog(@"3G");
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            NSLog(@"Wifi");
        }
            break;
            
        default:
            break;
    }
}

@end
