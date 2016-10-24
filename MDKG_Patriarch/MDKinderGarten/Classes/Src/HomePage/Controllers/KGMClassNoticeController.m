//
//  KGMClassNoticeController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassNoticeController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KGMClassInfoCell.h"

#import "KGMNoteService.h"

static NSString * const CellIdentify = @"KGMClassInfoCell";
@interface KGMClassNoticeController ()<KGMClassInfoCellDelegate>

@property (nonatomic, strong) KGMNoteService *noteService;
@property (nonatomic, strong) NSMutableArray *classNoteArr;

@end

@implementation KGMClassNoticeController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.haveRefresh = self.haveBottomRefresh = YES;
    self.tableViewStyle = PageRefreshTableViewStylePlain;
    [self.cusTableView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellReuseIdentifier:CellIdentify];
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
    return self.classNoteArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMClassInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self p_configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:CellIdentify cacheByIndexPath:indexPath configuration:^(id cell) {
        [self p_configurationCell:cell indexPath:indexPath];
    }];
}

#pragma mark - Custom Delegate
- (void)btnKnowClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath {
    KGMClassNoteDetailData *detailData = self.classNoteArr[indexPath.row];
    @weakify(self);
    [self.noteService changeNoteStatusWithUserId:[UserCenter sharedInstance].userId noteId:detailData.notice_id success:^(id data) {
        sender.backgroundColor = [UIColor lightGrayColor];
        sender.enabled = NO;
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - private method
- (void)p_configurationCell:(KGMClassInfoCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([self.classNoteArr count]) {
        KGMClassNoteDetailData *detailData = self.classNoteArr[indexPath.row];
        cell.detailData = detailData;
        cell.indexPath = indexPath;
        cell.delegate = self;
    }
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchNoteInfo];
}

- (void)loadMoreData {
    [self fetchNoteInfo];
}

- (void)fetchNoteInfo {
    @weakify(self);
    [self.noteService fetchClassNoteWithUserId:[UserCenter sharedInstance].userId classId:[UserCenter sharedInstance].classId currentPage:[@(self.currentPage) stringValue] pageCount:[@(self.pageCount) stringValue] success:^(id data) {
        @strongify(self);
        [self endRefreshing];
        KGMClassNoteDTO *result = (KGMClassNoteDTO *)data;
        
        self.totalPage = [result.data.page_count integerValue];
        NSArray *arr = result.data.class_notice;
        
        if (self.currentPage == 1) {
            [self.classNoteArr removeAllObjects];
        }
        [self.classNoteArr addObjectsFromArray:arr];
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

- (NSMutableArray *)classNoteArr {
    if (!_classNoteArr) {
        _classNoteArr = [NSMutableArray array];
    }
    return _classNoteArr;
}

@end
