//
//  GTLoginOutApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTLoginOutApi.h"

@interface GTLoginOutApi ()

@property (nonatomic, copy) NSString *userId;

@end

@implementation GTLoginOutApi

- (instancetype)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl {
    return LoginOutUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"user_id":self.userId};
}

@end
