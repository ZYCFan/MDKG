//
//  AppDelegate.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "AppDelegate.h"
#import "YTKNetworkConfig.h"
#import "BaseTabBarController.h"
#import "NewFeatureController.h"
#import "AdViewController.h"

#import "LoginController.h"

@interface AppDelegate ()<LoginDelegate>

@property (strong, nonatomic) NewFeatureController *starScreenVC;
@property (strong, nonatomic) AdViewController *adViewController;
@property (strong, nonatomic) BaseTabBarController *baseTabVC;
@property (assign, nonatomic) BOOL isLogin;

@end

@implementation AppDelegate

- (void)dealloc {
    TT_RELEASE_SAFELY(_starScreenVC);
    TT_RELEASE_SAFELY(_adViewController);
    TT_RELEASE_SAFELY(_window);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LoginController *loginVC = [[LoginController alloc]initWithViewController:self];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
    self.isLogin = [[[NSUserDefaults standardUserDefaults] valueForKey:IS_LOGIN] boolValue];
    if (!self.isLogin) {
        self.window.rootViewController = loginVC;
    } else {
        self.window.rootViewController = self.baseTabVC;
    }
    
//    [self integrateBPushNotificationWithApplication:application options:launchOptions];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self.window makeKeyAndVisible];
    
    
    /**
     *  判断是否有版本更新，如果有则展示引导页，否则加载广告页
     */
//    if (self.isFirst) {
//        self.starScreenVC = [[NewFeatureController alloc]init];
//        self.starScreenVC.ZYCBasicBlock = ^{
//            /**
//             *  引导页消失后要执行的动作
//             */
//        };
//        [self.starScreenVC showNewFeatureToWindow:self.window];
//    } else {
//        /**
//         以下是加载广告页
//         */
//        self.adViewController = [[AdViewController alloc]init];
//        self.adViewController.ZYCBasicBlock = ^{
//        };
//        [self.adViewController showOnWindow:self.window];
//    }
    
    return YES;
}

- (void)loginSuccess {
    self.window.rootViewController = self.baseTabVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - getter
- (BaseTabBarController *)baseTabVC {
    if (!_baseTabVC) {
        _baseTabVC = [[BaseTabBarController alloc]init];
    }
    return _baseTabVC;
}

@end
