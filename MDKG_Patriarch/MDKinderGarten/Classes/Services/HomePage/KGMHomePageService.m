//
//  KGMHomePageService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMHomePageService.h"
#import "KGMHomePageApi.h"
#import "KGMColleciontApi.h"

@interface KGMHomePageService ()

@property (nonatomic, strong) KGMHomePageApi *homePageApi;
@property (nonatomic, strong) KGMHomePageDTO *homePageDTO;

@property (nonatomic, strong) KGMColleciontApi *collectionApi;

@end

@implementation KGMHomePageService

- (void)fetchHomePageDataWithId:(NSString *)userId success:(successBlock)success failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_homePageApi);
    self.homePageApi = [[KGMHomePageApi alloc]initWithUserId:userId];
    [self.homePageApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        self.homePageDTO = [KGMHomePageDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([self.homePageDTO.code isEqualToString:@"200"]) {
            success(self.homePageDTO);
        } else {
            failure(self.homePageDTO.message);
        }
    } failure:^(YTKBaseRequest *request) {
        failure(@"网路请求错误");
    }];
}

- (void)collectionArticleWithUserId:(NSString *)userId topicId:(NSString *)topicId success:(successBlock)success failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_collectionApi);
    self.collectionApi = [[KGMColleciontApi alloc]initWithUserId:userId topicId:topicId];
    [self.collectionApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        KGMCollectionDTO *result = [KGMCollectionDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([result.code isEqualToString:@"200"]) {
            success(result);
        } else {
            failure(result.message);
        }
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求错误");
    }];
}

@end
