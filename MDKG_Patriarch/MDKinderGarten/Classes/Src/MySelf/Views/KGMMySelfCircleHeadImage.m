//
//  KGMMySelfCircleHeadImage.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMMySelfCircleHeadImage.h"
#import "UIImageView+WebCache.h"

@interface KGMMySelfCircleHeadImage ()

@property (nonatomic, strong) CAShapeLayer *shaperLayer;
@property (nonatomic, strong) UIImageView *headImageV;

@end

@implementation KGMMySelfCircleHeadImage

- (instancetype)init {
   return  [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self addSubview:self.headImageV];
    }
    return self;
}

- (void)setupView {
    _shaperLayer = [CAShapeLayer layer];
    _shaperLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _shaperLayer.path = path.CGPath;
    
    _shaperLayer.fillColor = [UIColor whiteColor].CGColor;
    _shaperLayer.lineWidth = 3.f;
    _shaperLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.4].CGColor;
    
    [self.layer addSublayer:_shaperLayer];
}

#pragma mark - setter
- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:imgUrl?:@""] placeholderImage:[UIImage imageNamed:@"user"]];
}

#pragma mark - getter
- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]initWithFrame:self.bounds];
        _headImageV.layer.cornerRadius = CGRectGetWidth(self.bounds) * 0.5;
        _headImageV.layer.masksToBounds = YES;
    }
    return _headImageV;
}

@end
