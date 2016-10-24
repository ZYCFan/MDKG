//
//  LoginFootView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "LoginFootView.h"

@interface LoginFootView ()

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *forgetPwdButton;
@property (nonatomic, assign) BOOL didConstraint;

@end

@implementation LoginFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loginButton];
        [self addSubview:self.registerButton];
        [self addSubview:self.forgetPwdButton];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    @weakify(self);
    if (!self.didConstraint) {
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self);
            make.left.equalTo(self.mas_left).offset(25);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.equalTo(@35);
        }];
        
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.loginButton.mas_bottom).offset(10);
            make.right.equalTo(self.loginButton);
            make.width.equalTo(@50);
        }];
        
        [self.forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.loginButton.mas_bottom).offset(10);
            make.left.equalTo(self.loginButton);
        }];
        
        self.didConstraint = YES;
    }
    [super updateConstraints];
}

#pragma mark - private methods
- (void)clickLogin:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loginButtonClicked:)]) {
        [self.delegate loginButtonClicked:sender];
    }
}

- (void)clickRegister:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(registerButtonClicked:)]) {
        [self.delegate registerButtonClicked:sender];
    }
}

- (void)clickForget:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(forgetButtonClicked:)]) {
        [self.delegate forgetButtonClicked:sender];
    }
}

#pragma mark - getters
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = NavBarColor;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 5.f;
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:NavBarColor forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _registerButton;
}

- (UIButton *)forgetPwdButton {
    if (!_forgetPwdButton) {
        _forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPwdButton setTitleColor:NavBarColor forState:UIControlStateNormal];
        [_forgetPwdButton addTarget:self action:@selector(clickForget:) forControlEvents:UIControlEventTouchUpInside];
        _forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _forgetPwdButton;
}

@end
