//
//  GTRegisterService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTRegisterService.h"
#import "GTRegisterApi.h"
#import "GTTakeCodeApi.h"

@interface GTRegisterService ()

@property (nonatomic, strong) GTTakeCodeApi *codeApi;
@property (nonatomic, strong) GTRegisterApi *registerApi;

@end

@implementation GTRegisterService

- (void)takeCodeWithTel:(NSString *)telNumber success:(void (^)(GTRegisterService *))success failure:(void (^)(NSString *))failure {
    HTTPMSG_RELEASE_SAFELY(_codeApi);
    self.codeApi = [[GTTakeCodeApi alloc]initWithUserTel:telNumber];
    [self.codeApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *result = request.responseJSONObject;
        self.result = result[@"result"];
        self.message = result[@"message"];
        if ([self.result isEqualToString:@"200"]) {
            success(self);
        } else {
            failure(self.message);
        }
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

- (void)registerWithParams:(GTRegisterParams *)registerParams success:(void (^)(GTRegisterService *))success failure:(void (^)(NSString *))failure {
    HTTPMSG_RELEASE_SAFELY(_registerApi);
    self.registerApi = [[GTRegisterApi alloc]initWithUserName:registerParams.userTel password:registerParams.userPassword code:registerParams.userCode];
    [self.registerApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *result = request.responseJSONObject;
        self.result = result[@"result"];
        self.message = result[@"message"];
        if ([self.result isEqualToString:@"200"]) {
            success(self);
        } else {
            failure(self.message);
        }
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

@end
