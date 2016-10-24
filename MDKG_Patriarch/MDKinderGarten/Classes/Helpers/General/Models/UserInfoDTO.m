//
//  UserInfoDTO.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UserInfoDTO.h"

static NSString *const USER_ID = @"userid";
static NSString *const USER_TOKEN = @"usertoken";
static NSString *const CLASS_ID = @"class_id";
static NSString *const USER_HEADIMAGE_URL = @"userheadimageurl";
@implementation UserInfoDTO

- (instancetype)initWithUserId:(NSString *)userId
                      userName:(NSString *)userName
                       classId:(NSString *)classId
                  userPassword:(NSString *)userPassword
                   userHeadUrl:(NSString *)userHeadUrl
                         token:(NSString *)token {
    self = [super init];
    if (self) {
        _userId = userId ?:@"";
        _userName = userName ?:@"";
        _classId = classId ?: @"";
        _userPassword = userPassword ?:@"";
        _userHeadUrl = userHeadUrl ?:@"";
        _userToken = token ?:@"";
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _userId = [aDecoder decodeObjectForKey:USER_ID];
        _classId = [aDecoder decodeObjectForKey:CLASS_ID];
        _userToken = [aDecoder decodeObjectForKey:USER_TOKEN];
        _userHeadUrl = [aDecoder decodeObjectForKey:USER_HEADIMAGE_URL];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userId forKey:USER_ID];
    [aCoder encodeObject:_classId forKey:CLASS_ID];
    [aCoder encodeObject:_userToken forKey:USER_TOKEN];
    [aCoder encodeObject:_userHeadUrl forKey:USER_HEADIMAGE_URL];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return nil;
}


@end
