//
//  KGMCourseService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"

#import "KGMWeekCourseDTO.h"
#import "KGMTodayCourseDTO.h"

@interface KGMCourseService : KGMBaseService

/**
 获取课程表内容

 @param classId 班级Id
 @param weekDay 星期
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchWeekCourseExcelWithClassId:(NSString *)classId
                                weekDay:(NSString *)weekDay
                                success:(successBlock)success
                                failure:(errorBlock)failure;

/**
 获取今日作业

 @param classId 班级Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchTodayCourseWithClassId:(NSString *)classId
                            success:(successBlock)success
                            failure:(errorBlock)failure;

@end
