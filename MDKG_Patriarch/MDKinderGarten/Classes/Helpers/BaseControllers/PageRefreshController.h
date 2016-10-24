//
//  PageRefreshController.h
//  MDKinderGarten
//  此类实现UITableView的刷新功能
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,PageRefreshTableViewStyle) {
    PageRefreshTableViewStylePlain,
    PageRefreshTableViewStyleGrouped,
};

@interface PageRefreshController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *cusTableView;

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pageCount;
@property (assign, nonatomic) NSInteger totalPage;

@property (assign, nonatomic) BOOL haveRefresh;
@property (assign, nonatomic) BOOL haveBottomRefresh;
@property (assign, nonatomic) PageRefreshTableViewStyle tableViewStyle;

/**
 *  上拉刷新 子类实现
 */
- (void)loadLastData;
/**
 *  下拉加载 子类实现
 */
- (void)loadMoreData;
/**
 *  结束刷新控件刷新
 */
- (void)endRefreshing;
/**
 *  请求数据（没有刷新控件的情况）
 */
- (void)loadDataWithoutNoRefresh;

@end
