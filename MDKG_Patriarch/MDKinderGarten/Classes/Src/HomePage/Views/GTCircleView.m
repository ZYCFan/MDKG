//
//  GTCircleView.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTCircleView.h"

@interface GTCircleView ()

@property (nonatomic, strong) CAShapeLayer *shaperLayer;
@property (nonatomic, strong) CAShapeLayer *dynamicShaperLayer;
@property (nonatomic, strong) UILabel *lblPercent;

@end

@implementation GTCircleView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _shaperLayer = [CAShapeLayer layer];
    _shaperLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _shaperLayer.path = path.CGPath;
    
    _shaperLayer.fillColor = [UIColor clearColor].CGColor;
    _shaperLayer.lineWidth = 3.0;
    _shaperLayer.strokeColor = TableViewColor.CGColor;
    
    
    _dynamicShaperLayer = [CAShapeLayer layer];
    _dynamicShaperLayer.frame = self.bounds;
    _dynamicShaperLayer.path = path.CGPath;
    _dynamicShaperLayer.fillColor = [UIColor clearColor].CGColor;
    _dynamicShaperLayer.lineWidth = 3.f;
    _dynamicShaperLayer.strokeEnd = 0.f;
    _dynamicShaperLayer.strokeColor = ColorYellow.CGColor;
    
    [_shaperLayer addSublayer:_dynamicShaperLayer];
    [self.layer addSublayer:_shaperLayer];
    
    _lblPercent = [[UILabel alloc]initWithFrame:CGRectMake(0,0,50,50)];
    _lblPercent.text = @"10.00%";
    _lblPercent.textColor = ColorYellow;
    _lblPercent.textAlignment = NSTextAlignmentCenter;
    _lblPercent.font = [UIFont systemFontOfSize:12];
    _lblPercent.center = CGPointMake(25, 25);
    [self addSubview:_lblPercent];
}

#pragma mark - setters
- (void)setStartValue:(CGFloat)startValue {
    _startValue = startValue;
    if (startValue < 0 || startValue > 1) {
        return;
    }
    _dynamicShaperLayer.strokeStart = startValue;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    if (lineWidth < 0) {
        return;
    }
    _dynamicShaperLayer.lineWidth = lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _dynamicShaperLayer.strokeColor = lineColor.CGColor;
}

- (void)setPercentValue:(CGFloat)percentValue {
    _percentValue = percentValue;
    if (percentValue < 0 || percentValue > 1) {
        return;
    }
    _lblPercent.text = percentValue == 1 ? @"100%":[NSString stringWithFormat:@"%.2f%%",_percentValue * 100];
    _dynamicShaperLayer.strokeEnd = percentValue;
}

@end
