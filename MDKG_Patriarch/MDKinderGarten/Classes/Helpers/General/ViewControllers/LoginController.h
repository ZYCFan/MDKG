//
//  LoginController.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginDelegate <NSObject>

@optional
- (void)loginSuccess;
- (void)loginFailure;

@end

/**
 *  登录界面
 */
@interface LoginController : BaseViewController

@property (nonatomic, weak) id<LoginDelegate> delegate;
- (instancetype)initWithViewController:(id<LoginDelegate>)viewController;
- (void)show;
- (void)hide;

@end
