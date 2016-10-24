//
//  KGMTeacherContractsController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTeacherContractsController.h"

#import "KGMMySelfService.h"
#import "KGMTeacherContractsDTO.h"

static NSString *const CellIdentify = @"KGMContractsCellIdentify";
@interface KGMTeacherContractsController ()

@property (nonatomic, strong) KGMMySelfService *contractsService;
@property (nonatomic, copy) NSArray *contractsListArr;

@end

@implementation KGMTeacherContractsController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    self.tableViewStyle = PageRefreshTableViewStylePlain;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教师通讯录";
    [self fetchContractsList];
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
    return self.contractsListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    cell.imageView.image = [UIImage imageNamed:@"teacher_icon"];
    cell.accessoryView = [self p_createAccessoryButton:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self p_configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - private methods
- (void)p_configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    KGMTeacherContractsData *data = self.contractsListArr[indexPath.row];
    cell.textLabel.text = data.teacher_name;
}

- (UIButton *)p_createAccessoryButton:(NSIndexPath *)indexPath {
    UIButton *accessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryBtn.frame = CGRectMake(0, 0, 44, 44);
    [accessoryBtn setImage:[UIImage imageNamed:@"call_icon"] forState:UIControlStateNormal];
    accessoryBtn.tag = indexPath.row;
    [accessoryBtn addTarget:self action:@selector(p_accessoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return accessoryBtn;
}

- (void)p_accessoryButtonClicked:(UIButton *)sender {
    
    KGMTeacherContractsData *data = self.contractsListArr[sender.tag];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",data.teacher_mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchContractsList];
}

- (void)fetchContractsList {
    @weakify(self);
    [self.contractsService fetchTeacherContractsWithClassId:[UserCenter sharedInstance].classId success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        NSArray *arr = ((KGMTeacherContractsDTO *)data).data;
        if (self.currentPage == 1) {
            self.contractsListArr = nil;
        }
        
        self.contractsListArr = arr;
        [self.cusTableView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (KGMMySelfService *)contractsService {
    if (!_contractsService) {
        _contractsService = [[KGMMySelfService alloc]init];
    }
    return _contractsService;
}

@end
