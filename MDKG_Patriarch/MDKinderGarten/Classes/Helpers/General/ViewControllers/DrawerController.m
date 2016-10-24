//
//  DrawerController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/2.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "DrawerController.h"

@interface DrawerController ()

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property (assign, nonatomic) BOOL didLayoutSubviews;

@end

@implementation DrawerController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.mainView];

    [self.view addGestureRecognizer:self.tapGesture];
    [self.mainView addGestureRecognizer:self.panGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxY = 0;
    self.offsetLeft = - (kDeviceWidth *0.7);
    self.offsetRight = kDeviceWidth * 0.7;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)tapView:(UITapGestureRecognizer *)tapGesture {
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

- (void)panView:(UIPanGestureRecognizer *)panGesture {
    CGPoint transP = [panGesture translationInView:self.mainView];
    self.mainView.frame = [self frameWithOffsetX:transP.x];
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = YES;
    } else if (self.mainView.frame.origin.x < 0) {
        self.rightView.hidden = NO;
    }
    
    CGFloat target = 0;
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x > kDeviceWidth * 0.5) {
            target = self.offsetRight;
        } else if (CGRectGetMaxX(self.mainView.frame) < kDeviceWidth * 0.5) {
            target = self.offsetLeft;
        }
        
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = [self frameWithOffsetX:offsetX];
        }];
    }
    [panGesture setTranslation:CGPointZero inView:self.mainView];
}

- (CGRect)frameWithOffsetX:(CGFloat)offsetX {
    CGRect rect = self.mainView.frame;
    rect.origin.x += offsetX;
    rect.origin.y = fabs(rect.origin.x * self.maxY / kDeviceWidth);
    rect.size.height = kDeviceHeight - 2 * rect.origin.y;
    return rect;
}

#pragma mark - getters
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:self.view.bounds];
        _mainView.backgroundColor = [UIColor redColor];
    }
    return _mainView;
}

- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:self.view.bounds];
        _leftView.backgroundColor = [UIColor orangeColor];
    }
    return _leftView;
}

- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:self.view.bounds];
        _rightView.backgroundColor = [UIColor yellowColor];
    }
    return _rightView;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    }
    return _tapGesture;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
    }
    return _panGesture;
}

@end
