//
//  KGMClassAlbumService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMBaseService.h"
#import "KGMClassAlbumListDTO.h"

@interface KGMClassAlbumService : KGMBaseService

/**
 获取班级相册列表数据

 @param classId 班级Id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)fetchClassAlbumListWithClassId:(NSString *)classId
                               success:(successBlock)success
                               failure:(errorBlock)failure;

@end
