//
//  HomePageController.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "HomePageController.h"
#import "KGMContainerController.h"
#import "KGMClassAlbumController.h"
#import "KGMHomePageService.h"

#import "KGMTopCell.h"
#import "KGMSecCell.h"
#import "KGMThirdCell.h"
#import "KGMForthCell.h"
#import "KGMBottmCell.h"

static NSString *const HomePageTopCellIdentify = @"HomePageCellTopCellIdentify";
static NSString *const HomePageSecCellIdentify = @"KGMSecCell";
static NSString *const HomePageThirdCellIdentify = @"HomePageCellThirdCellIdentify";
static NSString *const HomePageForthCellIdentify = @"KGMForthCell";
static NSString *const HomePageFifthCellIdentify = @"HomePageCellFifthCellIdentify";
@interface HomePageController ()<KGMSecCellDelegate,KGMForthCellDelegate>

@property (nonatomic, strong) KGMHomePageService *homePageService;

@property (nonatomic, strong) KGMWeatherData *weatherInfo;
@property (nonatomic, strong) NSArray *topicArr;

@end

@implementation HomePageController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserverToReachability];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    self.cusTableView.backgroundColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTableView.showsVerticalScrollIndicator = NO;
    [self.cusTableView registerNib:[UINib nibWithNibName:HomePageSecCellIdentify bundle:nil] forCellReuseIdentifier:HomePageSecCellIdentify];
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"麦豆宝贝幼儿园";
    [self customNavBarItem];
    [self.cusTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self.tabBarController.tabBar setBackgroundImage:nil];
    [self.tabBarController.tabBar setShadowImage:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cusTableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.topicArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            KGMTopCell *topCell = [[KGMTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageTopCellIdentify];
            topCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return topCell;
        }
            break;
        case 1:
        {
            KGMSecCell *secCell = [tableView dequeueReusableCellWithIdentifier:HomePageSecCellIdentify forIndexPath:indexPath];
            secCell.selectionStyle = UITableViewCellSelectionStyleNone;
            secCell.delegate = self;
            return secCell;
        }
            break;
        case 2:
        {
            KGMThirdCell *thirdCell = [[KGMThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageThirdCellIdentify];
            thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            thirdCell.weatherStr = self.weatherInfo.weather;
            thirdCell.weatherQuality = self.weatherInfo.air;
            return thirdCell;
        }
            break;
        case 3:
        {
            KGMForthCell *forthCell = [[KGMForthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageForthCellIdentify];
            forthCell.layer.cornerRadius = 5.f;
            forthCell.selectionStyle = UITableViewCellSelectionStyleNone;
            forthCell.indexPath = indexPath;
            forthCell.topicData = self.topicArr[indexPath.row];
            forthCell.delegate = self;
            return forthCell;
        }
            break;
        case 4:
        {
            KGMBottmCell *bottomCell = [[KGMBottmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomePageFifthCellIdentify];
            bottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return bottomCell;
        }
            break;
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 25.f;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc]init];
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth, 25)];
        titleL.text = @"热门话题";
        titleL.textColor = [UIColor whiteColor];
        [headerView.contentView addSubview:titleL];
        headerView.contentView.backgroundColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 100 * KGScreenRatio;
            break;
        case 1:
            return 250 * KGScreenRatio;
            break;
        case 2:
            return 90 * KGScreenRatio;
            break;
        case 3:
            return 295 * KGScreenRatio;
            break;
        case 4:
            return 100 * KGScreenRatio;
            break;
        default:
            return 100;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - CustomDelegate
- (void)tableViewCell:(KGMSecCell *)cell clickButton:(KGMClickButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            KGMContainerController *messageInfoVC = [[KGMContainerController alloc]initWithType:ContainerControllerTypeNotice];
            messageInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageInfoVC animated:YES];
        }
            break;
        case 2:
        {
            KGMContainerController *messageInfoVC = [[KGMContainerController alloc]initWithType:ContainerControllerTypeCourseAndTask];
            messageInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageInfoVC animated:YES];
        }
            break;
        case 3:
        {
            KGMClassAlbumController *classAlbumVC = [[KGMClassAlbumController alloc]init];
            classAlbumVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:classAlbumVC animated:YES];
        }
            break;
        case 4:
        {
            KGMContainerController *messageInfoVC = [[KGMContainerController alloc]initWithType:ContainerControllerTypeRecipes];
            messageInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageInfoVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)clickCollectionWithButton:(UIButton *)sender indexPath:(NSIndexPath *)indexPath {
    sender.enabled = NO;
    KGMTopicData *topicData = self.topicArr[indexPath.row];
    @weakify(self);
    [self.homePageService collectionArticleWithUserId:[UserCenter sharedInstance].userId topicId:topicData.topic_id success:^(id data) {
        @strongify(self);
        
        KGMCollectionDTO *result = (KGMCollectionDTO *)data;
        if ([result.col isEqualToString:@"0"]) {
            [sender setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
        } else {
            [sender setImage:[UIImage imageNamed:@"favorites_2"] forState:UIControlStateNormal];
        }
        [sender setTitle:result.topic_collection_num forState:UIControlStateNormal];
        [self displayActivityIndicatorView:result.message mode:MBProgressHUDModeText afterDelay:1];
        sender.enabled = YES;
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
        sender.enabled = YES;
    }];
}

#pragma mark - private methods
- (void)customNavBarItem {
    UIButton *btnHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeadImage.frame = CGRectMake(0, 0, 35, 35);
    btnHeadImage.layer.cornerRadius = 20.f;
    [btnHeadImage setBackgroundImage:[UIImage imageNamed:@"tx"] forState:UIControlStateNormal];
    [btnHeadImage setAdjustsImageWhenDisabled:YES];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:btnHeadImage];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchData];
}

- (void)loadMoreData {
    [self endRefreshing];
}

- (void)fetchData {
    @weakify(self);
    [self.homePageService fetchHomePageDataWithId:[UserCenter sharedInstance].userId success:^(id data) {
        @strongify(self);
        KGMHomePageDTO *homePageDTO = (KGMHomePageDTO *)data;
        self.weatherInfo = homePageDTO.data.weather;
        self.topicArr = homePageDTO.data.topic;
        [self.cusTableView reloadData];
        [self endRefreshing];
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
        [self endRefreshing];
    }];
}

#pragma mark - getter
- (KGMHomePageService *)homePageService {
    if (!_homePageService) {
        _homePageService = [[KGMHomePageService alloc]init];
    }
    return _homePageService;
}

@end
