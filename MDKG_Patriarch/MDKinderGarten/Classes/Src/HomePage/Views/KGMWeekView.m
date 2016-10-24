//
//  KGMWeekView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/8.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMWeekView.h"

@interface KGMWeekView ()

@property (nonatomic, strong) UIView *contanierView;
@property (nonatomic, copy) NSArray *weekArr;
@property (nonatomic, assign) BOOL didSetupView;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation KGMWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contanierView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contanierView.frame = self.bounds;
    [self setupView];
}

#pragma mark - private methods
- (void)setupView {
    if (!self.didSetupView) {
        CGFloat buttonX = 0.f;
        CGFloat buttonY = 25.f;
        CGFloat buttonW = CGRectGetWidth(self.bounds) / 7.0f;
        CGFloat buttonH = CGRectGetHeight(self.bounds);
        for (int i = 0; i < 7; ++i) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(buttonX + buttonW * i, buttonY, buttonW < buttonH ? buttonW : buttonH, buttonW < buttonH ? buttonW : buttonH);
            
            [btn setBackgroundImage:[UIImage imageNamed:@"circle_icon"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn.layer.cornerRadius = buttonW < buttonH ? buttonW * 0.5 : buttonH * 0.5;
            btn.layer.masksToBounds = YES;

            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setTitle:self.weekArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contanierView addSubview:btn];
            btn.tag = i;
            if (btn.tag == 0) {
                btn.selected = YES;
                self.selectedButton = btn;
            }
            
        }
        self.didSetupView = YES;
    }
}

- (void)btnClicked:(UIButton *)sender {
    if (!sender.selected) {
        self.selectedButton.selected = NO;
        sender.selected = YES;
        self.selectedButton = sender;
        
        if ([self.delegate respondsToSelector:@selector(view:clickDayButton:)]) {
            [self.delegate view:self clickDayButton:sender];
        }
    }
}

#pragma mark - getter
- (UIView *)contanierView {
    if (!_contanierView) {
        _contanierView = [[UIView alloc]init];
        _contanierView.backgroundColor = Color_RGB(251, 252, 253, 1);
    }
    return _contanierView;
}

- (NSArray *)weekArr {
    if (!_weekArr) {
        _weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    }
    return _weekArr;
}

@end
