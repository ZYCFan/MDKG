//
//  KGMMySelfController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMMySelfController.h"
#import "KGMSettingController.h"
#import "KGMTeacherContractsController.h"

#import "KGMMySelfTopCell.h"

static NSString *const CellIdentify = @"MySelfCellIdentify";
@interface KGMMySelfController ()

@property (nonatomic, copy) NSArray *leftTitleArr;
@property (nonatomic, copy) NSArray *leftImgArr;

@end

@implementation KGMMySelfController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(headImageChanged:) name:@"KMGHeadImageUrlChanged" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView {
    [super loadView];
//    self.tableViewStyle = PageRefreshTableViewStylePlain;
    self.cusTableView.bounces = NO;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cusTableView.frame = self.view.bounds;
    self.cusTableView.contentInset = UIEdgeInsetsMake(-1, 0, 0, 1);
    if ([self.cusTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.cusTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([self.cusTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.cusTableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArr = @[@1,@3,@1];
    return [rowArr[section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        KGMMySelfTopCell *topCell = [[KGMMySelfTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        topCell.headImgUrl = [UserCenter sharedInstance].headImageUrl;
        return topCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
        }
        if (indexPath.section == 1) {
            cell.imageView.image = [UIImage imageNamed:self.leftImgArr[indexPath.row]];
            cell.textLabel.text = self.leftTitleArr[indexPath.row];
        } else {
            cell.imageView.image = [UIImage imageNamed:self.leftImgArr[3]];
            cell.textLabel.text = self.leftTitleArr[3];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

#pragma mark - UITabelViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100 * KGScreenRatio;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 25.f;
    }
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                KGMSettingController *settingVC = [[KGMSettingController alloc]init];
                settingVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
            case 2:
            {
                KGMTeacherContractsController *contractsVC = [[KGMTeacherContractsController alloc]init];
                contractsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:contractsVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Notification method
- (void)headImageChanged:(NSNotification *)notifition {
    [self.cusTableView reloadData];
}

#pragma mark - getter
- (NSArray *)leftTitleArr {
    if (!_leftTitleArr) {
        _leftTitleArr = @[@"通用设置",@"我的收藏夹",@"教师通讯录",@"关于我们"];
    }
    return _leftTitleArr;
}

- (NSArray *)leftImgArr {
    if (!_leftImgArr) {
        _leftImgArr = @[@"options_icon",@"favorite_icon",@"guestbook_icon",@"about_icon"];
    }
    return _leftImgArr;
}

@end
