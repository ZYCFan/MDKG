//
//  KGMTeacherContractsApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTeacherContractsApi.h"

@interface KGMTeacherContractsApi ()

@property (nonatomic, copy) NSString *classId;

@end

@implementation KGMTeacherContractsApi

- (instancetype)initWithClassId:(NSString *)classId {
    self = [super init];
    if (self) {
        _classId = [classId copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return TeacherContractsUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"class_id":self.classId};
}

@end
