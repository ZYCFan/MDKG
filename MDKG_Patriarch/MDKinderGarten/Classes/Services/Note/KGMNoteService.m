//
//  KGMNoteService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMNoteService.h"
#import "KGMClassInfoApi.h"
#import "KGMEducationInfoApi.h"
#import "KGMKnowClassNoteApi.h"

@interface KGMNoteService ()

@property (nonatomic, strong) KGMClassInfoApi *classInfoApi;
@property (nonatomic, strong) KGMEducationInfoApi *educationApi;
@property (nonatomic, strong) KGMKnowClassNoteApi *knowStatusApi;

@end

@implementation KGMNoteService

- (void)fetchClassNoteWithUserId:(NSString *)userId
                         classId:(NSString *)classId
                     currentPage:(NSString *)currentPage
                       pageCount:(NSString *)pageCount
                         success:(successBlock)success
                         failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_classInfoApi);
    
    self.classInfoApi = [[KGMClassInfoApi alloc]initWithUserId:userId classId:classId currentPage:currentPage pageCount:pageCount];
    [self.classInfoApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMClassNoteDTO *resutlDTO = [KGMClassNoteDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resutlDTO.code isEqualToString:@"200"]) {
            success(resutlDTO);
        } else {
            failure(resutlDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求错误");
    }];
    
}

- (void)fetchEducationNoteWithCurrentPage:(NSString *)currentPage
                                pageCount:(NSString *)pageCount
                                  success:(successBlock)success
                                  failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_educationApi);
    
    self.educationApi = [[KGMEducationInfoApi alloc]initWithCurrentPage:currentPage pageCount:pageCount];
    
    [self.educationApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMEducationNoteDTO *resutlDTO = [KGMEducationNoteDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resutlDTO.code isEqualToString:@"200"]) {
            success(resutlDTO);
        } else {
            failure(resutlDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求错误");
    }];
}

- (void)changeNoteStatusWithUserId:(NSString *)userId
                            noteId:(NSString *)noteId
                           success:(successBlock)success
                           failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_knowStatusApi);
    self.knowStatusApi = [[KGMKnowClassNoteApi alloc]initWithUserId:userId noteId:noteId];
    [self.knowStatusApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        BaseDTO *resultDTO = [BaseDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求错误");
    }];
    
}

@end
