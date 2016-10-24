//
//  KGMSetNetworkController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMSetNetworkController.h"

static NSString *const CellIdentify = @"SetNetworkCellIdentify";
@interface KGMSetNetworkController ()

@property (nonatomic, strong) UISwitch *btnSwitch;

@end

@implementation KGMSetNetworkController
#pragma mark - life cyle 
- (void)loadView {
    [super loadView];
    self.tableViewStyle = PageRefreshTableViewStylePlain;
    self.cusTableView.bounces = NO;
    self.cusTableView.rowHeight = 44.f;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网络设置";
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cusTableView.frame = self.view.bounds;
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
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = @"是否使用2G/3G/4G播放";
    cell.accessoryView = self.btnSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - getter
- (UISwitch *)btnSwitch {
    if (!_btnSwitch) {
        _btnSwitch = [[UISwitch alloc]init];
        _btnSwitch.onTintColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
    }
    return _btnSwitch;
}

@end
