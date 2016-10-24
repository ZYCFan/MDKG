//
//  KGMTodayCourseController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTodayCourseController.h"
#import "KGMTodayCourseSectionView.h"
#import "KGMCourseContentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

#include "KGMCourseService.h"

static NSString *const CellIdentify = @"KGMCourseContentCell";
@interface KGMTodayCourseController ()<KGTodayCourseSectionViewDelegate>

@property (nonatomic, strong) KGMTodayCourseSectionView *sectionView;

@property (nonatomic, strong) KGMCourseService *courseService;
@property (nonatomic, copy) NSArray *todayCourseArr;
@property (nonatomic, copy) NSArray *singleCourseArr;

@end

@implementation KGMTodayCourseController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTableView.backgroundColor = [UIColor whiteColor];
    [self.cusTableView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellReuseIdentifier:CellIdentify];
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTodayCourse];
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
    return self.singleCourseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMCourseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.singleCourseArr count]) {
        [self p_configurationCell:cell indexPath:indexPath];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.sectionView calculateHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

#pragma mark - customDelegate
- (void)sectionView:(UIView *)view buttonClicked:(UIButton *)sender {
    KGMTodayCourseData *singleCourseData = self.todayCourseArr[sender.tag];
    self.singleCourseArr = singleCourseData.task_content;
    [self.cusTableView reloadData];
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchTodayCourse];
}

- (void)fetchTodayCourse {
    @weakify(self);
    [self.courseService fetchTodayCourseWithClassId:[UserCenter sharedInstance].classId success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        self.todayCourseArr = ((KGMTodayCourseDTO *)data).data;
        
        if ([self.todayCourseArr count]) {
            KGMTodayCourseData *singleData = self.todayCourseArr[0];
            self.singleCourseArr = singleData.task_content;
            
            self.sectionView.courseDataArr = self.todayCourseArr;
            self.sectionView.count = self.todayCourseArr.count;
        }
        
        [self.cusTableView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - private method
- (void)p_configurationCell:(KGMCourseContentCell *)cell indexPath:(NSIndexPath *)indexPath {
    KGMTodayCourseDetailData *data = self.singleCourseArr[indexPath.row];
    cell.detailData = data;
}

#pragma mark - getter
- (KGMTodayCourseSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[KGMTodayCourseSectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0) count:0];
        _sectionView.delegate = self;
    }
    return _sectionView;
}

- (KGMCourseService *)courseService {
    if (!_courseService) {
        _courseService = [[KGMCourseService alloc]init];
    }
    return _courseService;
}

@end
