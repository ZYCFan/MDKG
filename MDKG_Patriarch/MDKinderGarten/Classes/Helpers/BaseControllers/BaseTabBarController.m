//
//  BaseTabBarController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomePageController.h"
#import "KGMMySelfController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>
/**
 *  设置按钮的标题
 */
@property (copy, nonatomic) NSArray *tabBarTitles;
/**
 *  tabbar的图片
 */
@property (copy, nonatomic) NSDictionary *imageNameDict;
/**
 *  tabbar对应的控制器
 */
@property (copy, nonatomic) NSArray<UINavigationController *> *navigationControllers;

@end

@implementation BaseTabBarController

+ (void)load {
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 49 * ratio;
    tabFrame.origin.y = self.view.frame.size.height - 49 * ratio;
    self.tabBar.frame = tabFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - system Delegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    BaseNavigationController *navigationVC = (BaseNavigationController *)viewController;
//    if ([navigationVC.viewControllers[0] isKindOfClass:[ExtendController class]]) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - private methods
- (void)customTabBar {
    UIView *backView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    backView.backgroundColor = HomePageBottomColor;
    [[UITabBar appearance] insertSubview:backView atIndex:0];
    self.tabBar.translucent = NO;
    
    NSArray *normalImageNames = self.imageNameDict[@"normalImage"];
    NSArray *selectedImageNames = self.imageNameDict[@"selectedImage"];
    for (int i = 0; i < 4; i++) {
        UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:self.tabBarTitles[i] image:[UIImage imageNamed:normalImageNames[i]] selectedImage:[[UIImage imageNamed:selectedImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        tabItem.imageInsets = UIEdgeInsetsMake(6 * ratio, 0, -6 * ratio, 0);
        self.navigationControllers[i].tabBarItem = tabItem;
    }
    self.viewControllers = self.navigationControllers;
    self.delegate = self;
}

#pragma mark - getters
- (NSArray *)tabBarTitles {
    if (!_tabBarTitles) {
        _tabBarTitles = @[@"首页",@"麦豆课堂秀",@"班级群组",@"我的"];
    }
    return _tabBarTitles;
}

/**
 *  在此处替换UITabbar的图片
 *
 *  @return 返回图片字典
 */
- (NSDictionary *)imageNameDict {
    if (!_imageNameDict) {
        _imageNameDict = @{
                           @"selectedImage":
                               @[@"index_1",@"video_1",@"circle_1",@"user_1"],
                           @"normalImage":
                               @[@"index_2",@"video_2",@"circle_2",@"user_2"]};
    }
    return _imageNameDict;
}

- (NSArray *)navigationControllers {
    if (!_navigationControllers) {
        HomePageController *homePageVC = [[HomePageController alloc]init];
        UIViewController *projectVC = [[UIViewController alloc]init];
        UIViewController *extendVC = [[UIViewController alloc]init];
        KGMMySelfController *mySelfVC = [[KGMMySelfController alloc]init];
        
        NSArray *controllerArr = @[homePageVC,projectVC,extendVC,mySelfVC];
        
        NSMutableArray *navCollections = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            BaseNavigationController *navVC = [[BaseNavigationController alloc]initWithRootViewController:controllerArr[i]];
            [navCollections addObject:navVC];
        }
        _navigationControllers = navCollections;
    }
    return _navigationControllers;
}

@end
