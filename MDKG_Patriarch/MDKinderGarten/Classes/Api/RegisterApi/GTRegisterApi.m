//
//  GTRegisterApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTRegisterApi.h"

@interface GTRegisterApi ()

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passsword;
@property (nonatomic, copy) NSString *code;

@end

@implementation GTRegisterApi

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password code:(NSString *)code {
    self = [super init];
    if (self) {
        _userName = userName;
        _passsword = password;
        _code = code;
    }
    return self;
}

- (NSString *)requestUrl {
    return RegisterUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"user_tel":self.userName,
             @"user_pwd":self.passsword,
             @"sjyzm":self.code};
}

@end
