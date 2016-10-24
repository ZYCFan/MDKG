//
//  KGMTaskApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTaskApi.h"

@interface KGMTaskApi ()

@property (nonatomic, copy) NSString *classId;

@end

@implementation KGMTaskApi

- (instancetype)initWithClassId:(NSString *)classId {
    self = [super init];
    if (self) {
        _classId = [classId copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return TaskExcelUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"class_id":self.classId};
}

@end
