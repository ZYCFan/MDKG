//
//  KGMPersonalRecipesApi.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/18.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface KGMPersonalRecipesApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId
                       classId:(NSString *)classId
                          time:(NSString *)time
                          type:(NSString *)type
                           des:(NSString *)des;

@end
