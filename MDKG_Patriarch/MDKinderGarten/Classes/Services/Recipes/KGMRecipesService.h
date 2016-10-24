//
//  KGMRecipesService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"
#import "KGMWeekRecipesDTO.h"
#import "KGMPersonRecipesTypeDTO.h"

@interface KGMRecipesService : KGMBaseService

/**
 获取宝贝食谱

 @param classId 班级Id
 @param weekDay 星期
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchBabyRecipesWithClassId:(NSString *)classId
                            weekDay:(NSString *)weekDay
                            success:(successBlock)success
                            failure:(errorBlock)failure;

/**
 提交私人定制食谱

 @param userId  用户Id
 @param classId 班级Id
 @param time    时间
 @param type    类型
 @param des     内容
 @param success 成功回调
 @param failure 失败回调
 */
- (void)submitPersonRecipesWithUserId:(NSString *)userId
                              classId:(NSString *)classId
                                 time:(NSString *)time
                                 type:(NSString *)type
                                  des:(NSString *)des
                              success:(successBlock)success
                              failure:(errorBlock)failure;

/**
 获取私人定制类型

 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchPersonalTypeSuccess:(successBlock)success
                         failure:(errorBlock)failure;

@end
