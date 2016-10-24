//
//  KGMMySelfService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"
#import "KGMUploadImageDTO.h"

@interface KGMMySelfService : KGMBaseService

/**
 上传头像

 @param userId  用户Id
 @param data    用户头像二进制数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)uplodHeadImageWithUserId:(NSString *)userId
                       imageData:(NSData *)data
                         success:(successBlock)success
                         failure:(errorBlock)failure;

/**
 获取教师通讯录

 @param classId 班级Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchTeacherContractsWithClassId:(NSString *)classId
                                 success:(successBlock)success
                                 failure:(errorBlock)failure;

@end
