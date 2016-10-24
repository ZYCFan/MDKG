//
//  KGMRecipesService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMRecipesService.h"
#import "KGMWeekRecipesApi.h"
#import "KGMPersonalRecipesApi.h"
#import "KGMPersonalTypeApi.h"

@interface KGMRecipesService ()

@property (nonatomic, strong) KGMWeekRecipesApi *weekRecipesApi;
@property (nonatomic, strong) KGMPersonalRecipesApi *personRecipesApi;
@property (nonatomic, strong) KGMPersonalTypeApi *typeApi;

@end

@implementation KGMRecipesService

- (void)fetchBabyRecipesWithClassId:(NSString *)classId weekDay:(NSString *)weekDay success:(successBlock)success failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_weekRecipesApi);
    self.weekRecipesApi = [[KGMWeekRecipesApi alloc]initWithClassId:classId weekDay:weekDay];
    [self.weekRecipesApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMWeekRecipesDTO *resultDTO = [KGMWeekRecipesDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

- (void)submitPersonRecipesWithUserId:(NSString *)userId classId:(NSString *)classId time:(NSString *)time type:(NSString *)type des:(NSString *)des success:(successBlock)success failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_personRecipesApi);
    
    self.personRecipesApi = [[KGMPersonalRecipesApi alloc]initWithUserId:userId classId:classId time:time type:type des:des];
    [self.personRecipesApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        BaseDTO *resultDTO = [BaseDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
    
}

- (void)fetchPersonalTypeSuccess:(successBlock)success failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_typeApi);
    
    self.typeApi = [[KGMPersonalTypeApi alloc]init];
    [self.typeApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMPersonRecipesTypeDTO *resultDTO = [KGMPersonRecipesTypeDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

@end
