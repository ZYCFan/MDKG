//
//  KGMPersonalRecipesApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/18.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMPersonalRecipesApi.h"

@interface KGMPersonalRecipesApi ()

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *des;

@end

@implementation KGMPersonalRecipesApi

- (instancetype)initWithUserId:(NSString *)userId classId:(NSString *)classId time:(NSString *)time type:(NSString *)type des:(NSString *)des {
    self = [super init];
    if (self) {
        _userId = [userId copy];
        _classId = [classId copy];
        _time = [time copy];
        _type = [type copy];
        _des = [des copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return PersonalRecipesUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"student_id":self.userId,
             @"class_id":self.classId,
             @"dinzhi_time":self.time,
             @"dingzhi_type":self.type,
             @"dingzhi_intro":self.des};
}

@end
