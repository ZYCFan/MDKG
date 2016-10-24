//
//  KGMHomePageService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"
#import "KGMHomePageDTO.h"
#import "KGMCollectionDTO.h"

@interface KGMHomePageService : KGMBaseService

/**
 获取首页数据

 @param userId  用户Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchHomePageDataWithId:(NSString *)userId success:(successBlock)success failure:(errorBlock)failure;

/**
 收藏\取消收藏文章

 @param userId  用户ID
 @param topicId 文章Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)collectionArticleWithUserId:(NSString *)userId
                            topicId:(NSString *)topicId
                            success:(successBlock)success
                            failure:(errorBlock)failure;

@end
