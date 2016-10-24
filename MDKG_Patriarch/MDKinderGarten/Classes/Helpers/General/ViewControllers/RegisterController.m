//
//  RegisterController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterCell.h"
#import "RegisterFootView.h"

#import "GTRegisterService.h"

static NSString *const RegisterCellIdentify = @"RegisterCell";
@interface RegisterController ()<UITableViewDataSource,UITableViewDelegate,RegisterFootViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *registerTableView;
@property (nonatomic, strong) RegisterFootView *registerFootView;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, copy) NSArray *cellPlaceHolders;

@property (nonatomic, strong) GTRegisterParams *registerParams;
@property (nonatomic, strong) GTRegisterService *registerService;

@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *rePassword;

@end

@implementation RegisterController

- (void)dealloc {
    TT_RELEASE_SAFELY(_registerFootView);
    TT_RELEASE_SAFELY(_registerTableView);
}

- (void)loadView  {
    [super loadView];
    [self.view addSubview:self.registerTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.registerTableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSoruce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisterCellIdentify forIndexPath:indexPath];
    cell.RegisterTextField.placeholder = self.cellPlaceHolders[indexPath.row];
    cell.RegisterTextField.delegate = self;
    cell.RegisterTextField.tag = indexPath.row;
    [cell.RegisterTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 1) {
        cell.accessoryView = self.codeButton;
    }
    
    if (indexPath.row == 0) {
        cell.RegisterTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.RegisterTextField.secureTextEntry = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - custom delegate
- (void)registerClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    
    BOOL isMatch = [self verifyPassword];
    if (isMatch) {
        TT_RELEASE_SAFELY(_registerParams);
        self.registerParams = [[GTRegisterParams alloc]initWithUserTel:self.tel password:self.password code:self.code];
        [self.registerService registerWithParams:self.registerParams success:^(GTRegisterService *service) {
            [self displayActivityIndicatorView:service.message mode:MBProgressHUDModeText afterDelay:1];
            [self performSelector:@selector(popToPreviousController) withObject:nil afterDelay:1];
        } failure:^(NSString *errorStr) {
            [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
        }];
    } else {
        [self displayActivityIndicatorView:@"两次输入密码不一致" mode:MBProgressHUDModeText afterDelay:1];
    }
}

- (void)popToPreviousController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)verifyPassword {
    if ([self.password isEqualToString:self.rePassword]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - private methods
- (void)textFieldChanged:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            self.tel = textField.text ?:@"";
            break;
        case 1:
            self.code = textField.text ?:@"";
            break;
        case 2:
            self.password = textField.text ?:@"";
            break;
        case 3:
            self.rePassword = textField.text ?:@"";
            break;
            
        default:
            break;
    }
}

- (void)changeTimeInCodeBtn
{
    __block int timeout = 29;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout < 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                [self.codeButton setEnabled:YES];
            });
        }
        else {
            int seconds = timeout % 30;
            NSString *timeStr = [NSString stringWithFormat:@"已发送(%.2d)",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeButton setTitle:timeStr forState:UIControlStateNormal];
                [self.codeButton setEnabled:NO];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
/**
 *  获取验证码
 *
 *  @param sender 按钮
 */
- (void)takeCode:(UIButton *)sender {
    [self.view endEditing:YES];
    BOOL isTel = [Tools checkMobileNumber:self.tel];
    if (isTel) {
        @weakify(self);
        [self.registerService takeCodeWithTel:self.tel success:^(GTRegisterService *service) {
            @strongify(self);
            [self changeTimeInCodeBtn];
            [self displayActivityIndicatorView:service.message mode:MBProgressHUDModeText afterDelay:1];
        } failure:^(NSString *errorStr) {
            @strongify(self);   
            [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
        }];
    } else {
        [self displayActivityIndicatorView:@"手机号码格式错误!" mode:MBProgressHUDModeText afterDelay:1];
    }
}

#pragma mark - getters
- (UITableView *)registerTableView {
    if (!_registerTableView) {
        UITableViewController *tabVC = [[UITableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        _registerTableView = tabVC.tableView;
        _registerTableView.delegate = self;
        _registerTableView.dataSource = self;
        _registerTableView.rowHeight = 44;
        [_registerTableView registerNib:[UINib nibWithNibName:RegisterCellIdentify bundle:nil] forCellReuseIdentifier:RegisterCellIdentify];
        _registerTableView.tableFooterView = self.registerFootView;
        [self addChildViewController:tabVC];
    }
    return _registerTableView;
}

- (RegisterFootView *)registerFootView {
    if (!_registerFootView) {
        _registerFootView = [[RegisterFootView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
        _registerFootView.delegate = self;
    }
    return _registerFootView;
}

- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.frame = CGRectMake(0, 0, 100, 35);
        _codeButton.backgroundColor = NavBarColor;
        _codeButton.layer.cornerRadius = 5;
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(takeCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}

- (NSArray *)cellPlaceHolders {
    if (!_cellPlaceHolders) {
        _cellPlaceHolders = @[@"手机号",@"验证码",@"密码",@"确认密码"];
    }
    return _cellPlaceHolders;
}

- (GTRegisterParams *)registerParams {
    if (!_registerParams) {
        _registerParams = [[GTRegisterParams alloc]init];
    }
    return _registerParams;
}

- (GTRegisterService *)registerService {
    if (!_registerService) {
        _registerService = [[GTRegisterService alloc]init];
    }
    return _registerService;
}

@end
