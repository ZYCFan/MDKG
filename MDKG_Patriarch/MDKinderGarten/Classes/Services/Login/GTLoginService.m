//
//  GTLoginService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTLoginService.h"
#import "GTLoginApi.h"

@interface GTLoginService ()

@property (nonatomic, strong) GTLoginApi *loginApi;
@property (nonatomic, strong) GTLoginDTO *loginDTO;

@end

@implementation GTLoginService

- (void)loginWithParams:(GTLoginParams *)params success:(void (^)(GTLoginService *))success failure:(void (^)(NSString *))failure {
    HTTPMSG_RELEASE_SAFELY(_loginApi);
    self.loginApi = [[GTLoginApi alloc]initWithUserName:params.userName password:params.password];
    [self.loginApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        self.loginDTO = [GTLoginDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([self.loginDTO.code isEqualToString:@"200"]) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
            
            UserInfoDTO *userDTO = [[UserInfoDTO alloc]initWithUserId:self.loginDTO.data.student_id
                                                             userName:params.userName
                                                              classId:self.loginDTO.data.class_id
                                                         userPassword:params.password
                                                          userHeadUrl:self.loginDTO.data.student_head
                                                                token:self.loginDTO.token];
            [UserCenter sharedInstance].userInfo = userDTO;
            [[UserCenter sharedInstance] savePasswordAndAccount];
            success(self);
        } else {
            failure(self.loginDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

@end
