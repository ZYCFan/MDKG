//
//  KGMMySelfService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMMySelfService.h"
#import "KGMUpladImgApi.h"
#import "KGMTeacherContractsApi.h"

#import "KGMTeacherContractsDTO.h"

@interface KGMMySelfService ()

@property (nonatomic, strong) KGMUpladImgApi *uploadApi;
@property (nonatomic, strong) KGMTeacherContractsApi *contractsApi;

@end

@implementation KGMMySelfService

- (void)uplodHeadImageWithUserId:(NSString *)userId imageData:(NSData *)data success:(successBlock)success failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_uploadApi);
    self.uploadApi = [[KGMUpladImgApi alloc]initWithUserId:userId imgData:data];
    [self.uploadApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMUploadImageDTO *resultDTO = [KGMUploadImageDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

- (void)fetchTeacherContractsWithClassId:(NSString *)classId success:(successBlock)success failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_contractsApi);
    self.contractsApi = [[KGMTeacherContractsApi alloc]initWithClassId:classId];
    [self.contractsApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMTeacherContractsDTO *resultDTO = [KGMTeacherContractsDTO mj_objectWithKeyValues:request.responseJSONObject];
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
