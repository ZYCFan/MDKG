//
//  ZYCSecurity.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCSecurity : NSObject
/**
 *  加密数据
 *
 *  @param params 传递参数
 *  @param type   加密方式
 *
 *  @return 加密过的参数
 */
- (NSMutableDictionary *)encryptParams:(NSMutableDictionary *)params encryptType:(NSString *)type;
/**
 *  解密数据
 *
 *  @param responseObject 网络传递回来数据
 *
 *  @return 解密后的数据
 */
- (NSMutableDictionary *)decryptObject:(NSDictionary *)responseObject;


@end
