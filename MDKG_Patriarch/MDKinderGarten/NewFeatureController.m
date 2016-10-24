//
//  NewFeatureController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "NewFeatureController.h"

static NSInteger const DEFAULT_COUNT = 4;
@interface NewFeatureController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation NewFeatureController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImages];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(kDeviceWidth *DEFAULT_COUNT, kDeviceHeight);
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_scrollView);
    _ZYCBasicBlock = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - system delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 40) {
        scrollView.bounces = YES;
    } else {
        scrollView.bounces = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat space = scrollView.contentOffset.x - kDeviceWidth * (DEFAULT_COUNT - 1);
    if (space > 40) {
        [UIView animateWithDuration:0.4 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(-kDeviceWidth, 0);
        } completion:^(BOOL finished) {
            if (finished) {
                [self dismiss];
            }
        }];
    }
}

#pragma mark - public methods
- (void)showNewFeatureToWindow:(UIWindow *)window {
    [window addSubview:self.view];
}

#pragma mark - private methods
- (void)addImages {
    @autoreleasepool {
        for (int i = 0; i < DEFAULT_COUNT; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * kDeviceWidth, 0, kDeviceWidth, kDeviceHeight)];
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"NEWHELPER_%d",i+1]];
            [self.scrollView addSubview:imageV];
            TT_RELEASE_SAFELY(imageV);
        }
    }
}

- (void)dismiss {
    [self.view removeFromSuperview];
    if (self.ZYCBasicBlock) {
        self.ZYCBasicBlock();
    }
}

#pragma mark - setter
- (void)setZYCBasicBlock:(void (^)(void))ZYCBasicBlock {
    _ZYCBasicBlock = ZYCBasicBlock;
}

#pragma mark - getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator= NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

@end
