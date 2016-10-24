//
//  KGMWeekCourseController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMWeekCourseController.h"
#import "KGMWeekView.h"
#import "KGMTimetablesCell.h"

#import "KGMCourseService.h"

static NSString *const CellIdentify = @"KGMTimetablesCell";
@interface KGMWeekCourseController ()<KGMWeekViewDelegate>

@property (nonatomic, strong) KGMWeekView *weekView;

@property (nonatomic, copy) NSArray *colorArr;
@property (nonatomic, copy) NSArray *weekExcelArr;

@property (nonatomic, copy) NSString *selectedDay;
@property (nonatomic, strong) KGMCourseService *courseService;

@end

@implementation KGMWeekCourseController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    [self.cusTableView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellReuseIdentifier:CellIdentify];
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return self.weekExcelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMTimetablesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.leftView.backgroundColor = self.colorArr[indexPath.row % 5];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.courseData = self.weekExcelArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom Delegate
- (void)view:(KGMWeekView *)view clickDayButton:(UIButton *)sender {
    NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    self.selectedDay = weekArr[sender.tag];
    [self fetchWeekExcelDataWithWeek:self.selectedDay];
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchWeekExcelDataWithWeek:self.selectedDay ? :@"星期一"];
}

- (void)fetchWeekExcelDataWithWeek:(NSString *)weekDay {
    @weakify(self);
    [self.courseService fetchWeekCourseExcelWithClassId:[UserCenter sharedInstance].classId weekDay:weekDay success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        self.weekExcelArr = ((KGMWeekCourseDTO *)data).data;
        [self.cusTableView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (KGMWeekView *)weekView {
    if (!_weekView) {
        _weekView = [[KGMWeekView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 100)];
        _weekView.delegate = self;
    }
    return _weekView;
}

- (NSArray *)colorArr {
    if (!_colorArr) {
        _colorArr = @[Color_RGB(70, 192, 251, 1),
                      Color_RGB(252, 129, 141, 1),
                      Color_RGB(253, 213, 100, 1),
                      Color_RGB(130, 213, 253, 1),
                      Color_RGB(252, 178, 132, 1)];
    }
    return _colorArr;
}

- (KGMCourseService *)courseService {
    if (!_courseService) {
        _courseService = [[KGMCourseService alloc]init];
    }
    return _courseService;
}

@end
