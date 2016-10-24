//
//  PageRefreshController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "PageRefreshController.h"
#import "MJRefresh.h"

@interface PageRefreshController ()


@end

@implementation PageRefreshController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _currentPage = 0;
        _totalPage = 0;
        _tableViewStyle = PageRefreshTableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.haveRefresh) {
        [self setupRefreshView];
    } else {
        [self loadDataWithoutNoRefresh];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _cusTableView.dataSource = nil;
    _cusTableView.delegate = nil;
    TT_RELEASE_SAFELY(_cusTableView);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - private methods
- (void)setupRefreshView {
    @weakify(self);
    self.cusTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.currentPage = 1;
        [self loadLastData];
    }];
    
    if (self.haveBottomRefresh) {
        self.cusTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            if (self.currentPage < self.totalPage) {
                self.currentPage++;
                [self loadMoreData];
            } else {
                [self.cusTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
        self.cusTableView.mj_footer.hidden = YES;
    }
}

#pragma mark - networkRequest
- (void)loadLastData {
    
}

- (void)loadMoreData {
    
}

- (void)endRefreshing {
    [self.cusTableView.mj_header endRefreshing];
    [self.cusTableView.mj_footer endRefreshing];
}

- (void)loadDataWithoutNoRefresh {
    
}

#pragma mark - getters
- (UITableView *)cusTableView {
    if (!_cusTableView) {
        if (_tableViewStyle == PageRefreshTableViewStyleGrouped) {
            _cusTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        } else {
            _cusTableView = [[UITableView alloc]init];
        }
        
        _cusTableView.dataSource = self;
        _cusTableView.delegate = self;
        _cusTableView.backgroundColor = HomePageBottomColor;
        _cusTableView.sectionHeaderHeight = 0.0f;
        _cusTableView.sectionFooterHeight = 0.0f;
    }
    return _cusTableView;
}

- (NSInteger)pageCount {
    if (!_pageCount) {
        _pageCount = 10;
    }
    return _pageCount;
}

@end
