//
//  RegisterView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "RegisterFootView.h"

@interface RegisterFootView ()

@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *checkBoxButton;
@property (nonatomic, strong) UILabel *lblUserProtocol;
@property (nonatomic, strong) UIButton *userProtocolButton;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation RegisterFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.registerButton];
        [self addSubview:self.checkBoxButton];
        [self addSubview:self.lblUserProtocol];
        [self addSubview:self.userProtocolButton];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    @weakify(self);
    if (!self.didSetupConstraints) {
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self);
            make.left.equalTo(self).offset(25);
            make.right.equalTo(self).offset(-25);
            make.height.equalTo(@35);
        }];
        
        [self.checkBoxButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.registerButton.mas_bottom).offset(10);
            make.left.equalTo(self.registerButton);
            make.height.equalTo(@15);
            make.width.equalTo(self.checkBoxButton.mas_height);
        }];
        
        [self.lblUserProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.checkBoxButton);
            make.left.equalTo(self.checkBoxButton.mas_right).offset(5);
        }];
        
        [self.userProtocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lblUserProtocol);
            make.left.equalTo(self.lblUserProtocol.mas_right);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - private methods
- (void)checkBox:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)clickRegister:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(registerClicked:)]) {
        [self.delegate registerClicked:sender];
    }
}

#pragma mark - getters
- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = NavBarColor;
        [_registerButton setTitle:@"确认注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)checkBoxButton {
    if (!_checkBoxButton) {
        _checkBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBoxButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [_checkBoxButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [_checkBoxButton addTarget:self action:@selector(checkBox:) forControlEvents:UIControlEventTouchUpInside];
        _checkBoxButton.selected = YES;
    }
    return _checkBoxButton;
}

- (UILabel *)lblUserProtocol {
    if (!_lblUserProtocol) {
        _lblUserProtocol = [[UILabel alloc]init];
        _lblUserProtocol.font = [UIFont systemFontOfSize:14];
        _lblUserProtocol.text = @"同意";
    }
    return _lblUserProtocol;
}

- (UIButton *)userProtocolButton {
    if (!_userProtocolButton) {
        _userProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userProtocolButton.titleLabel.font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"《用户协议》" attributes:nil];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:NavBarColor} range:NSMakeRange(0, 6)];
        [_userProtocolButton setAttributedTitle:attrStr forState:UIControlStateNormal];
    }
    return _userProtocolButton;
}


@end
