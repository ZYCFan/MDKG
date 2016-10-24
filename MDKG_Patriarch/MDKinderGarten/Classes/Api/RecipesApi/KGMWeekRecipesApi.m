//
//  KGMWeekRecipesApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMWeekRecipesApi.h"

@interface KGMWeekRecipesApi ()

@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *weekDay;

@end

@implementation KGMWeekRecipesApi

- (instancetype)initWithClassId:(NSString *)classId weekDay:(NSString *)weekDay {
    self = [super init];
    if (self) {
        _classId = [classId copy];
        _weekDay = [weekDay copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return WeekRecipesUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"class_id":self.classId,
             @"week":self.weekDay};
}

@end
