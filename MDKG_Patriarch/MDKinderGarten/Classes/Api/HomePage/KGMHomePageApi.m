//
//  KGMHomePageApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMHomePageApi.h"

@interface KGMHomePageApi ()

@property (nonatomic, copy) NSString *userId;

@end

@implementation KGMHomePageApi

- (instancetype)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl {
    return HomePageUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"student_id":self.userId};
}

@end
