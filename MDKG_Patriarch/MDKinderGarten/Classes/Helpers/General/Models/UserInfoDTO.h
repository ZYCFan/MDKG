//
//  UserInfoDTO.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDTO : NSObject<NSCoding>

@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *classId;
@property (copy, nonatomic) NSString *userPassword;
@property (copy, nonatomic) NSString *userHeadUrl;
@property (copy, nonatomic) NSString *userToken;

- (instancetype)initWithUserId:(NSString *)userId
                      userName:(NSString *)userName
                       classId:(NSString *)classId
                  userPassword:(NSString *)userPassword
                   userHeadUrl:(NSString *)userHeadUrl
                         token:(NSString *)token;

@end
