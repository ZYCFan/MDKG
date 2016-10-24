//
//  GTRegisterParams.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTRegisterParams.h"

@implementation GTRegisterParams

- (instancetype)init {
    return [self initWithUserTel:nil password:nil code:nil];
}

- (instancetype)initWithUserTel:(NSString *)userTel password:(NSString *)password code:(NSString *)code {
    self = [super init];
    if (self) {
        _userTel = userTel;
        _userPassword = password;
        _userCode = code;
    }
    return self;
}

@end
