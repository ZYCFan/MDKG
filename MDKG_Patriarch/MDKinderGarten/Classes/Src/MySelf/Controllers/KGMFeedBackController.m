//
//  KGMFeedBackController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMFeedBackController.h"
#import "KGMFeedBackCell.h"

static NSString *const CellIdentify = @"FeedBackIdentify";
@interface KGMFeedBackController ()

@property (nonatomic, strong) UIView *footV;
@property (nonatomic, strong) UIButton *btnSubmit;

@end

@implementation KGMFeedBackController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.cusTableView.bounces = NO;
    self.cusTableView.tableFooterView = self.footV;
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个性留言";
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cusTableView.frame = self.view.bounds;
    self.btnSubmit.frame = CGRectMake(25 * KGScreenRatio , 25, kDeviceWidth - 50 * KGScreenRatio, 40 * KGScreenRatio);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

#pragma mark - private Methods
- (void)submitMessage:(UIButton *)sender {
    
}

#pragma mark - getter
- (UIView *)footV {
    if (!_footV) {
        _footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 65 * KGScreenRatio)];
        _footV.backgroundColor = HomePageBottomColor;
        [_footV addSubview:self.btnSubmit];
    }
    return _footV;
}

- (UIButton *)btnSubmit {
    if (!_btnSubmit) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.backgroundColor = UIButtonBottomColor;
        _btnSubmit.layer.cornerRadius = 5.f;
        [_btnSubmit setTitle:@"提交留言" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

@end
