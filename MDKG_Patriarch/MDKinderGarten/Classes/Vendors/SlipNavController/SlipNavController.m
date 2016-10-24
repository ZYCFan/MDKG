//
//  SlipNavController.m
//  SlipNavController
//
//  Created by YNC on 15-4-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SlipNavController.h"
#import "SlipNavBar.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define STATUS_BAR_HEIGT 20
#define STATUS_BAR_HEIGHT 20
#define NAV_BAR_HEIGHT 45
@interface SlipNavController () <UIScrollViewDelegate, SlipNavBarDelegate>
/** 当前页面索引值 */
@property (assign, nonatomic)  NSInteger currentIndex;
/** 子控制器tilte数组 */
@property (strong, nonatomic) NSMutableArray *titles;
/** 底部容器View */
@property (strong, nonatomic) UIScrollView *mainView;
/** SlipNavBar*/
@property (strong, nonatomic) SlipNavBar *navTabBar;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *leftView;
@property (assign, nonatomic)  CGRect headFrame;

@property (assign, nonatomic) NSInteger vcTag;

@property (strong, nonatomic) UIViewController *currentVC;
@end

@implementation SlipNavController

#pragma mark - Life Cycle
#pragma mark -

- (instancetype)initWithLeftView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        _leftView = view;
    }
    return self;
}
- (instancetype)initWithRightView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        _rightView = view;
    }
    return self;
}
- (instancetype)initWithLeftView:(UIView *)leftView
                    andRightView:(UIView *)rightView
{
    self = [super init];
    if (self)
    {
        _leftView = leftView;
        _rightView = rightView;
    }
    return self;
}

- (instancetype)initWithSubViewControllers:(NSArray *)controllers titles:(NSArray *)titles {
    self = [super init];
    if (self) {
        _subViewControllers = controllers;
        _titles = [titles mutableCopy];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConfig];
    [self viewConfig];
//    [_navTabBar selectAtIndex:self.defaultSelectedIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -
- (void)initConfig
{
    // Iinitialize value
    _currentIndex =  1;
    _navTabBarColor = _navTabBarColor ? _navTabBarColor : [UIColor blackColor];
    // Load all title of children view controllers
//    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
//    for (UIViewController *viewController in _subViewControllers)
//    {
//        [_titles addObject:viewController.title];
//    }
}

- (void)viewInit
{
    // 整体
    // Load NavTabBar and content view to show on window
//    _headFrame = CGRectMake(DOT_COORDINATE, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAV_BAR_HEIGHT);
    _headFrame = CGRectMake(DOT_COORDINATE, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT);
    if (_leftView != nil && _rightView == nil) { // 仅有左侧按钮
        _navTabBar = [[SlipNavBar alloc] initWithFrame:_headFrame leftView:_leftView];
    } else if (_leftView == nil && _rightView != nil) { // 仅有右侧按钮
        _navTabBar = [[SlipNavBar alloc] initWithFrame:_headFrame rightView:_rightView];
    } else if (_leftView != nil && _rightView != nil) { // 两侧都有
        _navTabBar = [[SlipNavBar alloc] initWithFrame:_headFrame leftView:_leftView andRightView:_rightView];
    } else { // 两侧都没有
        _navTabBar = [[SlipNavBar alloc] initWithFrame:_headFrame];
    }
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = _navTabBarColor;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.userInteractionEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
}

- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
//    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//        
//        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
//        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, CGRectGetMaxY(_navTabBar.frame), SCREEN_WIDTH, _mainView.frame.size.height - CGRectGetMaxY(_navTabBar.frame));
//        [_mainView addSubview:viewController.view];
//        [self addChildViewController:viewController];
//    }];
    
    UIViewController *defaultVC = (UIViewController *)_subViewControllers[0];
    defaultVC.view.frame = CGRectMake(0, CGRectGetMaxY(_navTabBar.frame), SCREEN_WIDTH, _mainView.frame.size.height - CGRectGetMaxY(_navTabBar.frame) - 64.f);
    self.currentVC = defaultVC;
    [self.mainView addSubview:defaultVC.view];
    [self addChildViewController:defaultVC];
}

#pragma mark - Public Methods
#pragma mark -

- (void)setNavTabBarRightView:(UIView *)navTabBarRightView
{
   _navTabBar.rightViewToShow = navTabBarRightView;
}
//- (void)setNavTabbarColor:(UIColor *)navTabbarColor
//{
//    // prevent set [UIColor clear], because this set can take error display
//    CGFloat red, green, blue, alpha;
//    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
//    {
//        navTabbarColor = NAV_TAB_BAR_COLOR;
//    }
//    _navTabBarColor = navTabbarColor;
//}

- (void)setNavTabBarLineColor:(UIColor *)navTabBarLineColor {
    _navTabBarLineColor = navTabBarLineColor;
    _navTabBar.lineColor = navTabBarLineColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}
#pragma mark - Scroll View Delegate Methods
#pragma mark -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;

    _navTabBar.currentItemIndex = _currentIndex;
    [self initChildControllerAtIndex:_currentIndex];
}

- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * self.mainView.frame.size.width, DOT_COORDINATE) animated:NO];
    if (!self.currentVC) {
        self.currentVC = (UIViewController *)_subViewControllers[0];
    }
    _currentIndex = index;
    [self initChildControllerAtIndex:index];
}

- (void)initChildControllerAtIndex:(NSInteger)index {
    UIViewController *newVC = (UIViewController *)_subViewControllers[index];
    newVC.view.frame = CGRectMake(_currentIndex * SCREEN_WIDTH, CGRectGetMaxY(_navTabBar.frame), SCREEN_WIDTH, _mainView.frame.size.height - CGRectGetMaxY(_navTabBar.frame) - 64.f);
    if (self.currentVC != newVC) {
        [self replaceController:self.currentVC newController:newVC];
    }
}

- (void)replaceController:(UIViewController *)oldViewController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [newController didMoveToParentViewController:self];
    [oldViewController willMoveToParentViewController:nil];
    [oldViewController removeFromParentViewController];
    [self.mainView addSubview:newController.view];
    self.currentVC = newController;
//    [self transitionFromViewController:oldViewController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
//        if (finished) {
//            [newController didMoveToParentViewController:self];
//            [oldViewController willMoveToParentViewController:nil];
//            [oldViewController removeFromParentViewController];
//            [self.mainView addSubview:newController.view];
//            self.currentVC = newController;
//        } else {
//            self.currentVC = oldViewController;
//        }
//    }];
}

#pragma mark - Setter
- (void)setNavTabBarTitles:(NSArray *)navTabBarTitles {
    _navTabBarTitles  = navTabBarTitles;
    _titles = [navTabBarTitles mutableCopy];
}

@end
