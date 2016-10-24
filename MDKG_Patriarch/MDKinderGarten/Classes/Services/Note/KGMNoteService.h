//
//  KGMNoteService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"

#import "KGMClassNoteDTO.h"
#import "KGMEducationNoteDTO.h"

@interface KGMNoteService : KGMBaseService

/**
 获取班级通知

 @param userId      用户Id
 @param classId     班级Id
 @param currentPage 当前页数
 @param pageCount   每页显示条数
 @param sucess      成功回调
 @param failure     失败回调
 */
- (void)fetchClassNoteWithUserId:(NSString *)userId
                         classId:(NSString *)classId
                     currentPage:(NSString *)currentPage
                       pageCount:(NSString *)pageCount
                         success:(successBlock)sucess
                         failure:(errorBlock)failure;

/**
 获取教育局通知
 
 @param currentPage 当前页数
 @param pageCount   每页显示条数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchEducationNoteWithCurrentPage:(NSString *)currentPage
                                pageCount:(NSString *)pageCount
                                  success:(successBlock)success
                                  failure:(errorBlock)failure;

/**
 改变通知状态

 @param userId  用户Id
 @param noteId  通知Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)changeNoteStatusWithUserId:(NSString *)userId
                            noteId:(NSString *)noteId
                           success:(successBlock)success
                           failure:(errorBlock)failure;

@end
