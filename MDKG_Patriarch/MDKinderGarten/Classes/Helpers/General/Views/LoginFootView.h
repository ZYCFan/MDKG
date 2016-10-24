//
//  LoginFootView.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginFootViewDelegate <NSObject>

- (void)loginButtonClicked:(UIButton *)sender;
- (void)registerButtonClicked:(UIButton *)sender;
- (void)forgetButtonClicked:(UIButton *)sender;

@end

@interface LoginFootView : UIView

@property (nonatomic, weak) id<LoginFootViewDelegate> delegate;

@end
