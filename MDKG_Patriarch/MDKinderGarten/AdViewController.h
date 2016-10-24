//
//  AdViewController.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/29.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdViewController : UIViewController

@property (copy, nonatomic) void (^ZYCBasicBlock)(void);

- (void)showOnWindow:(UIWindow *)window;

@end
