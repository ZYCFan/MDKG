//
//  KGMClassInfoApi.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface KGMClassInfoApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId
                       classId:(NSString *)classId
                   currentPage:(NSString *)currentPage
                     pageCount:(NSString *)pageCount;

@end
