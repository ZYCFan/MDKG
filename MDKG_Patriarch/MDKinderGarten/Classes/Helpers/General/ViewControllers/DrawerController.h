//
//  DrawerController.h
//  MDKinderGarten

//  仿原qq抽屉视图
//  用法:DrawerController *drawer = [[DrawerController alloc]init];
//  [self addChildViewController:drawer];
//  [self.view addSubview:drawer.view];
//  UIViewController *control = [[UINavigationController alloc]initWithRootViewController:[[UIViewController alloc]init]];
//  [drawer.mainView addSubview:control.view];
//  [drawer addChildViewController:control];
//  drawer.maxY = 100;

//  Created by zhouyongchao on 16/2/2.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerController : UIViewController

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;

@property (assign, nonatomic) CGFloat maxY;
@property (assign, nonatomic) CGFloat offsetLeft;
@property (assign, nonatomic) CGFloat offsetRight;

@end
