//
//  KGMClickButton.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClickButton.h"

@implementation KGMClickButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height - 40 * KGRatio * KGScreenRatio - 10 *KGScreenRatio;
    CGFloat x = 0.f;
    CGFloat y = 40 * KGRatio * KGScreenRatio + 10 * KGScreenRatio;
    return CGRectMake(x, y, width, height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat width = 40 * KGRatio * KGScreenRatio;
    CGFloat height = width;
    CGFloat x = (contentRect.size.width - width) /2;
    CGFloat y = 0.f;
    return CGRectMake(x, y, width, height);
}

@end
