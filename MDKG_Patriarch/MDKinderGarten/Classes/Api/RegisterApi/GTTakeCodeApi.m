//
//  GTTakeCodeApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTTakeCodeApi.h"

@interface GTTakeCodeApi ()

@property (nonatomic, copy) NSString *userTel;

@end

@implementation GTTakeCodeApi

- (instancetype)initWithUserTel:(NSString *)userTel {
    self = [super init];
    if (self) {
        _userTel = userTel;
    }
    return self;
}

- (NSString *)requestUrl {
    return TakeCodeUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"user_tel":self.userTel};
}

@end
