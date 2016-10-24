//
//  KGMPersonalTypeApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMPersonalTypeApi.h"

@implementation KGMPersonalTypeApi

- (NSString *)requestUrl {
    return PersonalTypeUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

@end
