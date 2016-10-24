//
//  KGMWebUrlController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/18.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMWebUrlController.h"
#import <WebKit/WebKit.h>

@interface KGMWebUrlController ()<WKNavigationDelegate>

@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation KGMWebUrlController

#pragma mark - life cycle
- (instancetype)initWithWebUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _webUrl = [url copy];
    }
    return self;
}

- (void)loadView {
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl ?: @""]]];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
