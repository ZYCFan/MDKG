//
//  KGMWeekRecipesController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMWeekRecipesController.h"
#import "KGMWebUrlController.h"
#import "KGMWeekView.h"
#import "KGMRecipesCell.h"

#import "KGMRecipesService.h"

static NSString *const CellIdentify = @"KGMRecipesCell";

@interface KGMWeekRecipesController ()<KGMWeekViewDelegate>

@property (nonatomic, strong) KGMWeekView *weekView;
@property (nonatomic, copy) NSString *selectedDay;

@property (nonatomic, strong) KGMRecipesService *recipesService;
@property (nonatomic, copy) NSArray *recipesArr;

@end

@implementation KGMWeekRecipesController

- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    self.cusTableView.backgroundColor = [UIColor whiteColor];
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cusTableView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellReuseIdentifier:CellIdentify];
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cusTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cusTableView.frame = self.view.bounds;
    CGRect frame = self.cusTableView.frame;
    frame.origin.y += 100.f;
    frame.size.height -= 100.f;
    self.cusTableView.frame = frame;
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
    return self.recipesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMRecipesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.layer.cornerRadius = 5.f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 0.5f;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self p_configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KGMWeekRecipesData *data = self.recipesArr[indexPath.row];
    KGMWebUrlController *webVC = [[KGMWebUrlController alloc]initWithWebUrl:data.img];
    webVC.navigationItem.title = @"详情";
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Custom Delegate
- (void)view:(KGMWeekView *)view clickDayButton:(UIButton *)sender {
    NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    self.selectedDay = weekArr[sender.tag];
    [self fetchWeekRecipesDataWithWeekDay:self.selectedDay];
}

#pragma mark - networkRequest
- (void)fetchWeekRecipesDataWithWeekDay:(NSString *)day {
    @weakify(self);
    [self.recipesService fetchBabyRecipesWithClassId:[UserCenter sharedInstance].classId weekDay:day success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        self.recipesArr = ((KGMWeekRecipesDTO *)data).data;
        [self.cusTableView reloadData];
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - inherit method
- (void)loadLastData {
    [self fetchWeekRecipesDataWithWeekDay:self.selectedDay ?: @"星期一"];
}

#pragma mark - private method
- (void)p_configurationCell:(KGMRecipesCell *)cell indexPath:(NSIndexPath *)indexPath {
    KGMWeekRecipesData *data = self.recipesArr[indexPath.row];
    cell.data = data;
}

#pragma mark - getter
- (KGMWeekView *)weekView {
    if (!_weekView) {
        _weekView = [[KGMWeekView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 100)];
        _weekView.delegate = self;
    }
    return _weekView;
}

- (KGMRecipesService *)recipesService {
    if (!_recipesService) {
        _recipesService = [[KGMRecipesService alloc]init];
    }
    return _recipesService;
}

@end
