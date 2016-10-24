//
//  KGMEducationNoticeController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMEducationNoticeController.h"
#import "KGMWebUrlController.h"
#import "KGMEducationInfoCell.h"

#import "KGMNoteService.h"

static NSString *const CellIdentify = @"KGMEducationInfoCell";
@interface KGMEducationNoticeController ()

@property (nonatomic, strong) KGMNoteService *noteService;
@property (nonatomic, strong) NSMutableArray *educationNoteArr;

@end

@implementation KGMEducationNoticeController

- (void)loadView {
    [super loadView];
    self.haveRefresh = self.haveBottomRefresh = YES;
    [self.cusTableView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellReuseIdentifier:CellIdentify];
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cusTableView.mj_header beginRefreshing];
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
    return self.educationNoteArr.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMEducationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.cornerRadius = 5.f;
    
    if ([self.educationNoteArr count]) {
        KGMEducationNoteDetailData *detailData = self.educationNoteArr[indexPath.row];
        cell.detailData = detailData;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"此处通知内容由当地教育局通知";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KGMEducationNoteDetailData *detailData = self.educationNoteArr[indexPath.row];
    KGMWebUrlController *webVC = [[KGMWebUrlController alloc]initWithWebUrl:detailData.edu_url];
    webVC.navigationItem.title = @"详情";
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchEducationNoteInfo];
}

- (void)loadMoreData {
    [self fetchEducationNoteInfo];
}

- (void)fetchEducationNoteInfo {
    @weakify(self);
    [self.noteService fetchEducationNoteWithCurrentPage:[@(self.currentPage) stringValue] pageCount:[@(self.pageCount) stringValue] success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        KGMEducationNoteDTO *resultDTO = (KGMEducationNoteDTO *)data;
        self.totalPage = [resultDTO.data.page_count integerValue];
        NSArray *arr = resultDTO.data.edu_notice;
        if (self.currentPage == 1) {
            [self.educationNoteArr removeAllObjects];
        }
        [self.educationNoteArr addObjectsFromArray:arr];
        [self.cusTableView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (KGMNoteService *)noteService {
    if (!_noteService) {
        _noteService = [[KGMNoteService alloc]init];
    }
    return _noteService;
}

- (NSMutableArray *)educationNoteArr {
    if (!_educationNoteArr) {
        _educationNoteArr = [NSMutableArray array];
    }
    return _educationNoteArr;
}

@end
