//
//  KGMSettingController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMSettingController.h"
#import "KGMFeedBackController.h"
#import "KGMSetNetworkController.h"

#import "UIViewController+UploadHeadImage.h"
#import "UIImageView+WebCache.h"

#import "KGMMySelfService.h"

static NSString *const CellIdentify = @"SettingCellIdentify";
@interface KGMSettingController ()

@property (nonatomic, copy) NSDictionary *leftTitleDict;
@property (nonatomic, copy) NSDictionary *leftImageDict;

@property (nonatomic, strong) UIImageView *headImageV;

@property (nonatomic, strong) KGMMySelfService *uploadService;

@end

@implementation KGMSettingController

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
    self.cusTableView.bounces = NO;
    self.cusTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.cusTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通用设置";
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
    return 4;
}

- (__kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentify];
    }
    cell.imageView.image = [UIImage imageNamed:[self.leftImageDict valueForKey:[@(indexPath.section) stringValue]][indexPath.row]];
    cell.textLabel.text = [self.leftTitleDict valueForKey:[@(indexPath.section) stringValue]][indexPath.row];
    if (indexPath.row == 0) {
        cell.accessoryView = self.headImageV;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 55.f;
    }
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self uploadButtonClicked:nil];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            KGMSetNetworkController *setNetworkVC = [[KGMSetNetworkController alloc]init];
            [self.navigationController pushViewController:setNetworkVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Category method
- (void)savePicture:(NSData *)imageData {
    [self uploadImage:imageData];
}

#pragma mark - networkReqeust 
- (void)uploadImage:(NSData *)imageData {
    @weakify(self);
    [self.uploadService uplodHeadImageWithUserId:[UserCenter sharedInstance].userId imageData:imageData success:^(id data) {
        @strongify(self);
        
        NSString *currentImageUrl = ((KGMUploadImageDTO *)data).data.head_url;
        self.headImageV.image = self.uploadImage;
        [[UserCenter sharedInstance] replaceUserHeadImageUrl:currentImageUrl];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KMGHeadImageUrlChanged" object:nil];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (NSDictionary *)leftImageDict {
    if (!_leftImageDict) {
        _leftImageDict = @{@"0":@[@"userhead_icon",@"password_icon",@"protection_icon",@"internet_icon"]};
    }
    return _leftImageDict;
}

- (NSDictionary *)leftTitleDict {
    if (!_leftTitleDict) {
        _leftTitleDict = @{@"0":@[@"上传头像",@"修改密码",@"密码保护",@"网络设置"]};
    }
    return _leftTitleDict;
}

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        [_headImageV sd_setImageWithURL:[NSURL URLWithString:[UserCenter sharedInstance].headImageUrl] placeholderImage:[UIImage imageNamed:@"teacher_icon"]];
        _headImageV.layer.cornerRadius = 22.5f;
        _headImageV.layer.masksToBounds = YES;
        _headImageV.backgroundColor = [UIColor lightGrayColor];
    }
    return _headImageV;
}

- (KGMMySelfService *)uploadService {
    if (!_uploadService) {
        _uploadService = [[KGMMySelfService alloc]init];
    }
    return _uploadService;
}

@end
