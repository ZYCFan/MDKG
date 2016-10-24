//
//  KGMRecipesTypeController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/18.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMRecipesTypeController.h"
#import "KGMRecipesService.h"

static NSString *const CellIdentify = @"RecipesTypeCellIdentify";
@interface KGMRecipesTypeController ()

@property (nonatomic, copy) dismissBlock block;

@property (nonatomic, strong) KGMRecipesService *recipesService;
@property (nonatomic, strong) NSMutableArray *typeArr;

@end

@implementation KGMRecipesTypeController

#pragma mark - life cycle 

- (instancetype)initWithBlock:(dismissBlock)block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)dealloc {
//    DLog(@"delloc %@", [[self class] description]);
}

- (void)loadView {
    [super loadView];
    self.haveRefresh = YES;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"类型";
    [self fetchTypeData];
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

#pragma mark - UITableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    [self p_configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KGMPersonRecipesTypeData *data = self.typeArr[indexPath.row];
    if (self.block) {
        self.block(data.type);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods
- (void)p_configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if ([self.typeArr count]) {
        KGMPersonRecipesTypeData *data = self.typeArr[indexPath.row];
        cell.textLabel.text = data.type;
    }
}

#pragma mark - networkRequest
- (void)loadLastData {
    [self fetchTypeData];
}

- (void)fetchTypeData {
    
    @weakify(self);
    [self.recipesService fetchPersonalTypeSuccess:^(id data) {
        @strongify(self);
        [self endRefreshing];
        NSArray *arr = ((KGMPersonRecipesTypeDTO *)data).data;
        if (self.currentPage == 1) {
            [self.typeArr removeAllObjects];
        }
        [self.typeArr addObjectsFromArray:arr];
        [self.cusTableView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self endRefreshing];
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (KGMRecipesService *)recipesService {
    if (!_recipesService) {
        _recipesService = [[KGMRecipesService alloc]init];
    }
    return _recipesService;
}

- (NSMutableArray *)typeArr {
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

@end
