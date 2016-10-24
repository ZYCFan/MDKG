//
//  KGMPersonalRecipesController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMPersonalRecipesController.h"
#import "KGMRecipesTypeController.h"
#import "KGMPersonRecipeCell.h"

#import "IQUIView+IQKeyboardToolbar.h"

#import "KGMRecipesService.h"

static NSString *const CellIdentify = @"CellIdentify";
@interface KGMPersonalRecipesController ()<KGMPersonRecipeCellDelegate>

@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) UIView *footV;
@property (nonatomic, strong) KGMPersonRecipeCell *firstCell;

@property (nonatomic, strong) NSDate *dateTime;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, copy) NSString *contentStr;

@property (nonatomic, strong) KGMRecipesService *recipesService;

@end

@implementation KGMPersonalRecipesController

- (void)loadView {
    [super loadView];
    self.cusTableView.backgroundColor = [UIColor whiteColor];
    self.cusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cusTableView.tableFooterView = self.footV;
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMPersonRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        if (indexPath.section != 2) {
            cell = [[KGMPersonRecipeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify cellType:0];
        } else {
            cell = [[KGMPersonRecipeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil cellType:1];
        }
    }
    if (indexPath.section == 0) {
        cell.delegate = self;
        self.firstCell = cell;
    }
    
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textView setCustomDoneTarget:self action:@selector(IQToolbarClicked:)];
    }
    [self configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        return 60;
    }
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50.f)];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kDeviceWidth, 40.f)];
    lblTitle.text = self.titleArr[section];
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.textColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
    [headV addSubview:lblTitle];
    return headV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.firstCell becomeFirstResponder];
        
    } else if (indexPath.section == 1) {
        
        KGMRecipesTypeController *typeVC = [[KGMRecipesTypeController alloc]initWithBlock:^(NSString *str) {
            self.typeStr = str;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:typeVC animated:YES];
    }
}

#pragma mark - Custom Delegate
- (void)tableViewCell:(KGMPersonRecipeCell *)cell datePickerClicked:(UIDatePicker *)datePicker {
    self.dateTime = datePicker.date;
    [self.cusTableView reloadData];
}

#pragma mark - private methods
- (void)configurationCell:(KGMPersonRecipeCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        cell.textLabel.text = [dateFormatter stringFromDate:self.dateTime ?: [NSDate date]];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.typeStr;
    }
}

- (void)IQToolbarClicked:(UITextView *)textView {
    self.contentStr = textView.text;
}

- (void)submitAction:(UIButton *)sender {
    if (self.typeStr.length == 0) {
        [self displayActivityIndicatorView:@"请选择类型" mode:MBProgressHUDModeText afterDelay:1];
        return;
    } else if (self.contentStr.length == 0) {
        [self displayActivityIndicatorView:@"请输入内容" mode:MBProgressHUDModeText afterDelay:1];
        return;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormatter stringFromDate:self.dateTime ?: [NSDate date]];
    
    @weakify(self);
    [self.recipesService submitPersonRecipesWithUserId:[UserCenter sharedInstance].userId
                                               classId:[UserCenter sharedInstance].classId
                                                  time:dateStr
                                                  type:self.typeStr
                                                   des:self.contentStr
                                               success:^(id data)
     {
                                                   
         @strongify(self);
         BaseDTO *resultDTO = (BaseDTO *)data;
         [self displayActivityIndicatorView:resultDTO.message mode:MBProgressHUDModeText afterDelay:1];
         
        
    }
                                               failure:^(NSString *errorStr)
     {
         @strongify(self);
         [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"日期:",@"类型:",@"内容:"];
    }
    return _titleArr;
}

- (UIView *)footV {
    if (!_footV) {
        _footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 85)];
        UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSubmit.backgroundColor = VERSION_MAN ? GlobalColor_MAN :GlobalColor_Female;
        [btnSubmit setTitle:@"立即提交" forState:UIControlStateNormal];
        [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnSubmit.frame = CGRectMake(25, 25, kDeviceWidth - 50, 40);
        btnSubmit.layer.cornerRadius = 5.f;
        [btnSubmit addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footV addSubview:btnSubmit];
    }
    return _footV;
}

- (KGMRecipesService *)recipesService {
    if (!_recipesService) {
        _recipesService = [[KGMRecipesService alloc]init];
    }
    return _recipesService;
}

@end
