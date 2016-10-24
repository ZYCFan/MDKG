//
//  KGMTodayCourseTopView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/10.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTodayCourseTopView.h"

@interface KGMTodayCourseTopView ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation KGMTodayCourseTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btnCourse];
        [self addSubview:self.lblDes];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        @weakify(self);
        [self.btnCourse mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.top.right.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        [self.lblDes mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerX.equalTo(self.btnCourse);
            make.bottom.equalTo(self);
        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - getter
- (UIButton *)btnCourse {
    if (!_btnCourse) {
        _btnCourse = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCourse setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnCourse setTitleColor:VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female forState:UIControlStateNormal];
        
        _btnCourse.adjustsImageWhenHighlighted = NO;
        _btnCourse.layer.borderColor = VERSION_MAN ? GlobalColor_MAN.CGColor : GlobalColor_Female.CGColor;
        _btnCourse.layer.borderWidth = 0.5f;
        _btnCourse.layer.cornerRadius = 5.f;
        _btnCourse.layer.masksToBounds = YES;
        [_btnCourse setBackgroundImage:[Tools createImageWithColor:VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female] forState:UIControlStateSelected];
        [_btnCourse setBackgroundImage:[Tools createImageWithColor:HomePageBottomColor] forState:UIControlStateNormal];
    }
    return _btnCourse;
}

- (UILabel *)lblDes {
    if (!_lblDes) {
        _lblDes = [[UILabel alloc]init];
        _lblDes.font = [UIFont systemFontOfSize:15];
        _lblDes.textColor = [UIColor darkGrayColor];
        _lblDes.text = @"测试文本";
    }
    return _lblDes;
}

@end
