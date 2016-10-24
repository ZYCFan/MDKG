//
//  GTLoginOutService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTLoginOutService.h"
#import "GTLoginOutApi.h"

@interface GTLoginOutService()

@property (nonatomic, strong) GTLoginOutApi *loginOutApi;

@end

@implementation GTLoginOutService

- (void)loginOutWithUserId:(NSString *)userId success:(void (^)(GTLoginOutService *))success failure:(void (^)(NSString *))failure {
    HTTPMSG_RELEASE_SAFELY(_loginOutApi);
    self.loginOutApi = [[GTLoginOutApi alloc]initWithUserId:userId];
    [self.loginOutApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *result = request.responseJSONObject;
        self.result = result[@"result"];
        self.message = result[@"message"];
        if ([self.result isEqualToString:@"200"]) {
            [[UserCenter sharedInstance] deletePasswordAndAccount];
            success(self);
        } else {
            failure(self.message);
        }
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败!");
    }];
}

@end
