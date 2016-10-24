//
//  KGMTodayCourseSectionView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/10.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTodayCourseSectionView.h"
#import "KGMTodayCourseTopView.h"

#import "KGMTodayCourseDTO.h"

@interface KGMTodayCourseSectionView ()

@property (nonatomic, assign) NSInteger buttonCount;
@property (nonatomic, assign) BOOL didSetupView;

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation KGMTodayCourseSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonCount = 3;
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonCount = count;
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setupView {
    CGFloat buttonXSpaces = 25 * KGScreenRatio;
    CGFloat buttonYSpaces = 15 *KGScreenRatio;
    
    CGFloat buttonX = 0.f;
    CGFloat buttonY = 25.f;
    CGFloat buttonW = (CGRectGetWidth(self.bounds) - 25 * KGScreenRatio * 4) / 3.f;
    CGFloat buttonH = 65.f;
    
    for (int i = 0; i < self.buttonCount; ++i) {
        KGMTodayCourseTopView *topView = [[KGMTodayCourseTopView alloc]initWithFrame:CGRectMake(buttonX + ((i % 3) + 1) * buttonXSpaces + (i % 3) * buttonW, buttonY + (i / 3) * (buttonYSpaces + buttonH), buttonW, buttonH)];
        [topView.btnCourse addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        KGMTodayCourseData *data = self.courseDataArr[i];
        [topView.btnCourse setTitle:data.task_name forState:UIControlStateNormal];
        topView.lblDes.text = data.task_have;
        
        [self addSubview:topView];
        
        topView.btnCourse.tag = i;
        if (i == 0) {
            topView.btnCourse.selected = YES;
            self.selectedButton = topView.btnCourse;
        }
    }
}

- (CGFloat)calculateHeight {
    CGFloat row = ceil(self.buttonCount / 3.f);
    return 90 + (row - 1) * 15 * KGScreenRatio + (row - 1) * 65.f + 25;
}

#pragma mark - setter
- (void)setCount:(NSInteger)count {
    _count = count;
    for (KGMTodayCourseTopView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.buttonCount = count;
    [self setupView];
}


#pragma mark - getter

- (void)btnClicked:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        self.selectedButton.selected = NO;
        self.selectedButton = sender;
        
        if ([self.delegate respondsToSelector:@selector(sectionView:buttonClicked:)]) {
            [self.delegate sectionView:self buttonClicked:sender];
        }
    }
}

@end
