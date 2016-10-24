//
//  UserCenter.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/27.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoDTO.h"

@interface UserCenter : NSObject
DEF_SINGLETON(UserCenter);
/**
 *  判断用户是否登录
 */
@property (assign, nonatomic, getter=isLogined, readonly) BOOL logined;
/**
 *  当前登录用户的用户Id
 */
@property (copy, nonatomic, readonly) NSString *userId;

/**
 当前登录用户的classId
 */
@property (copy, nonatomic, readonly) NSString *classId;
/**
 *  当前登录用户的头像路径
 */
@property (copy, nonatomic, readonly) NSString *headImageUrl;
/**
 *  服务器返回的token
 */
@property (copy, nonatomic, readonly) NSString *token;
/**
 *  登录成功以后返回的用户信息，只需要登录后设置一次
 */
@property (strong, nonatomic) UserInfoDTO *userInfo;
/**
 *  获取密码
 *
 *  @return 密码
 */
- (NSString *)takeUserPassword;
/**
 *  获取用户名
 *
 *  @return 用户名
 */
- (NSString *)takeUserAccount;
/**
 *  保存用户名和密码
 */
- (void)savePasswordAndAccount;
/**
 *  删除用户名和密码
 */
- (void)deletePasswordAndAccount;
/**
 *  退出登录删除用户登录信息
 */
- (void)deleteUserInfoWhenLoginOut;
/**
 *  用户更换头像以后更新归档信息中的头像
 *
 *  @param url 头像url
 */
- (void)replaceUserHeadImageUrl:(NSString *)url;


@end
