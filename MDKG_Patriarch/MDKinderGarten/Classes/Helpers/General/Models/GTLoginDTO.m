//
//  GTLoginDTO.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "GTLoginDTO.h"

@implementation GTLoginParams

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName ?:@"";
        _password = password ?:@"";
    }
    return self;
}

@end

@implementation GTLoginUserInfo


@end

@implementation GTLoginDTO

@end
