//
//  LoginController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "LoginController.h"
#import "IQKeyboardManager.h"
#import "RegisterController.h"

#import "LoginCell.h"

#import "GTLoginService.h"

static NSString *const DefaultCellIdentify = @"defaultCell";
static NSString *const LoginCellIdentify = @"LoginCell";
@interface LoginController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *loginTableView;
@property (nonatomic, strong) id<LoginDelegate> presentViewController;
@property (nonatomic, strong) UIButton *btnLogin;
@property (nonatomic, strong) UIButton *btnForget;

@property (nonatomic, copy) NSArray *placeHolderArr;
@property (nonatomic, copy) NSArray *leftImageArr;
@property (nonatomic, copy) NSArray *imageArr;

@property (nonatomic, strong) GTLoginService *loginService;
@property (nonatomic, strong) GTLoginParams *loginParams;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end

@implementation LoginController

- (instancetype)initWithViewController:(id<LoginDelegate>)viewController {
    self = [super init];
    if (self) {
        if (viewController) {
            self.delegate = viewController;
        }
        _presentViewController = viewController;
    }
    return self;
}

- (instancetype )init {
    return [self initWithViewController:nil];
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_loginTableView);
    TT_RELEASE_SAFELY(_presentViewController);
}

#pragma mark - life cycle 
- (void)loadView {
    [super loadView];
    [self.view addSubview:self.loginTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self customNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.loginTableView.frame = self.view.bounds;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentify];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCellIdentify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArr[indexPath.row]]];
        if (indexPath.row == 3) {
            [cell.contentView addSubview:self.btnLogin];
            [cell.contentView addSubview:self.btnForget];
        }
        return cell;
    } else {
        LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:LoginCellIdentify forIndexPath:indexPath];

        cell.textField.placeholder = self.placeHolderArr[indexPath.row-1];
        cell.textField.tag = indexPath.row;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
        if (indexPath.row == 1) {
            self.userName = [UserCenter sharedInstance].takeUserAccount;
            cell.textField.text = [UserCenter sharedInstance].takeUserAccount;
        } else {
            cell.textField.secureTextEntry = YES;
        }
        
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArr[indexPath.row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rowHeightArr = @[@(220.f * KGScreenRatio),@(80.f * KGScreenRatio),@(80.f * KGScreenRatio),@(287.f * KGScreenRatio)];
    return [rowHeightArr[indexPath.row] floatValue];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - custom Delegate
- (void)loginButtonClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [self displayActivityIndicatorView:@"正在登录" mode:0];
    TT_RELEASE_SAFELY(_loginParams);
    self.loginParams = [[GTLoginParams alloc]initWithUserName:self.userName password:self.password];
    self.loginService = [[GTLoginService alloc]init];
    [self.loginService loginWithParams:self.loginParams success:^(GTLoginService *service) {
        [self removeActivityIndicatorView];
        [self displayActivityIndicatorView:@"登录成功!" mode:MBProgressHUDModeText afterDelay:1];
        if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
            [self.delegate loginSuccess];
        }
    } failure:^(NSString *errorStr) {
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerButtonClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    RegisterController *registerVC = [[RegisterController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)forgetButtonClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    DLog(@"点击忘记密码");
}

#pragma mark - private Methods
- (void)customNavBar {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)closeAction:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldChanged:(UITextField *)textField {
    switch (textField.tag) {
        case 1:
            self.userName = textField.text ?:@"";
            break;
        case 2:
            self.password = textField.text ?:@"";
            break;
            
        default:
            break;
    }
}

#pragma mark - public Methods
- (void)show {
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:self];
    [((UIViewController *)self.presentViewController) presentViewController:loginNav animated:YES completion:nil];
}

- (void)hide {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter
#pragma mark - getter
- (UITableView *)loginTableView {
    if (!_loginTableView) {
        _loginTableView = [[UITableView alloc]init];
        _loginTableView.delegate = self;
        _loginTableView.dataSource = self;
        _loginTableView.bounces = NO;
        _loginTableView.backgroundColor = [UIColor whiteColor];
        _loginTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_loginTableView registerClass:[LoginCell class] forCellReuseIdentifier:LoginCellIdentify];
    }
    return _loginTableView;
}

- (UIButton *)btnLogin {
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(35 * KGScreenRatio, 15 * KGScreenRatio, kDeviceWidth - 80 * KGScreenRatio, 50 * KGScreenRatio);
        [_btnLogin setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
        _btnLogin.layer.cornerRadius = 25 *KGScreenRatio;
        _btnLogin.layer.masksToBounds = YES;
        [_btnLogin addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}

- (UIButton *)btnForget {
    if (!_btnForget) {
        _btnForget = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnForget setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnForget setTitle:@"忘记密码，联系客服？" forState:UIControlStateNormal];
        _btnForget.titleLabel.font = [UIFont systemFontOfSize:16];
        
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGSize size = [@"忘记密码，联系客服？" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        _btnForget.frame = CGRectMake(35 * KGScreenRatio, CGRectGetMaxY(self.btnLogin.frame) + 5 * KGScreenRatio, size.width, 40 *KGScreenRatio);
        NSLogRect(_btnForget.frame);
    }
    return _btnForget;
}

- (NSArray *)placeHolderArr {
    if (!_placeHolderArr) {
        _placeHolderArr = @[@"请输入登录账号",@"请输入密码"];
    }
    return _placeHolderArr;
}

- (NSArray *)leftImageArr {
    if (!_leftImageArr) {
        _leftImageArr = @[@"username",@"password"];
    }
    return _leftImageArr;
}

- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = @[@"login_bg_1",@"login_bg_2",@"login_bg_3",@"login_bg_4"];
    }
    return _imageArr;
}

- (GTLoginService *)loginService {
    if (!_loginService) {
        _loginService = [[GTLoginService alloc]init];
    }
    return _loginService;
}

@end
