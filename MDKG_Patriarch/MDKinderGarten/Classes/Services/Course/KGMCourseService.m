//
//  KGMCourseService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMCourseService.h"
#import "KGMCourseExcelApi.h"
#import "KGMTaskApi.h"

@interface KGMCourseService ()

@property (nonatomic, strong) KGMCourseExcelApi *courseExcelApi;
@property (nonatomic, strong) KGMTaskApi *taskApi;

@end

@implementation KGMCourseService

- (void)fetchWeekCourseExcelWithClassId:(NSString *)classId
                                weekDay:(NSString *)weekDay
                                success:(successBlock)success
                                failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_courseExcelApi);
    self.courseExcelApi = [[KGMCourseExcelApi alloc]initWithClassId:classId weekDay:weekDay];
    
    [self.courseExcelApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMWeekCourseDTO *resultDTO = [KGMWeekCourseDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
    
}

- (void)fetchTodayCourseWithClassId:(NSString *)classId
                            success:(successBlock)success
                            failure:(errorBlock)failure {
    
    HTTPMSG_RELEASE_SAFELY(_taskApi);
    self.taskApi = [[KGMTaskApi alloc]initWithClassId:classId];
    
    [self.taskApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMTodayCourseDTO *resultDTO = [KGMTodayCourseDTO mj_objectWithKeyValues:request.responseJSONObject];
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
