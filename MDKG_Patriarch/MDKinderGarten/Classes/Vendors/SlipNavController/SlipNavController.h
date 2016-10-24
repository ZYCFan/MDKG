//
//  SlipNavController.h
//  SlipNavController
//
//  Created by YNC on 15-4-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlipNavController : UIViewController

@property (nonatomic, assign)   BOOL        scrollAnimation;            // Default value: NO
@property (nonatomic, assign)   BOOL        mainViewBounces;            // Default value: NO

@property (nonatomic, strong)   NSArray     *subViewControllers;        // An array of
@property (nonatomic, strong)   NSArray     *navTabBarTitles;
@property (nonatomic, strong)   UIColor     *navTabBarColor;            // Could not set
@property (nonatomic, strong)   UIColor     *navTabBarLineColor;
@property (assign, nonatomic) NSInteger defaultSelectedIndex;

/**
 *  Initialize Methods
 */
//- (ini)
- (instancetype)initWithRightView:(UIView *)view;
- (instancetype)initWithLeftView:(UIView *)view;
- (instancetype)initWithLeftView:(UIView *)leftView andRightView:(UIView *)rightView;
- (instancetype)initWithSubViewControllers:(NSArray *)controllers titles:(NSArray *)titles;

/**
 *  Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 */
- (void)addParentController:(UIViewController *)viewController;
@end
