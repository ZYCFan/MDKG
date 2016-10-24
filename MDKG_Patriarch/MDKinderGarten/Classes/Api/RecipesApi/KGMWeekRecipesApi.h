//
//  KGMWeekRecipesApi.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface KGMWeekRecipesApi : YTKRequest

- (instancetype)initWithClassId:(NSString *)classId weekDay:(NSString *)weekDay;

@end
