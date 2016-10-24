//
//  AdViewController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/29.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "AdViewController.h"

@interface AdViewController ()

@property (strong, nonatomic) UIImageView *adImageV;
@property (strong, nonatomic) UIButton *countBtn;

@end

@implementation AdViewController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.adImageV];
    [self.view addSubview:self.countBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.adImageV.frame = self.view.bounds;
    self.countBtn.frame = CGRectMake((kDeviceWidth - 35) *ratio, 35 *ratio, 20 *ratio, 25 *ratio);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_adImageV);
    TT_RELEASE_SAFELY(_countBtn);
    _ZYCBasicBlock = nil;
}

#pragma mark - Public method
- (void)showOnWindow:(UIWindow *)window {
    [window addSubview:self.view];
}

#pragma mark - private method
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        self.adImageV.transform = self.countBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        self.adImageV.alpha = self.countBtn.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.countBtn removeFromSuperview];
        [self.adImageV removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
    if (self.ZYCBasicBlock) {
        self.ZYCBasicBlock();
    }
}

-(void)startTime{
    __block int timeout = 4; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    @weakify(self);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                [self dismiss];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.countBtn setTitle:[@(timeout) stringValue] forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark - setter
- (void)setZYCBasicBlock:(void (^)(void))ZYCBasicBlock {
    _ZYCBasicBlock = ZYCBasicBlock;
}

#pragma mark - getter
- (UIImageView *)adImageV {
    if (!_adImageV) {
        _adImageV = [[UIImageView alloc]init];
        _adImageV.image = [UIImage imageNamed:@"NEWHELPER_1"];
    }
    return _adImageV;
}

- (UIButton *)countBtn {
    if (!_countBtn) {
        _countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _countBtn.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        _countBtn.layer.cornerRadius = 2 *ratio;
    }
    return _countBtn;
}

@end
