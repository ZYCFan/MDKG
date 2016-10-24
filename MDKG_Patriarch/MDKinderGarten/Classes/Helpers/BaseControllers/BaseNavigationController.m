//
//  BaseNavigationController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
+ (void)initialize
{
    UINavigationBar *navBarAppearance = [UINavigationBar appearance];
    navBarAppearance.tintColor = [UIColor whiteColor];
    navBarAppearance.barTintColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
    navBarAppearance.translucent = NO;
    [navBarAppearance setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19 * ratio],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect navFrame = self.navigationBar.frame;
    navFrame.size.height = 44 * ratio;
    self.navigationBar.frame = navFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        rootViewController.navigationItem.backBarButtonItem = backItem;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    viewController.navigationItem.backBarButtonItem = backItem;
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
