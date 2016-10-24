//
//  MCCustomSecurity.h
//  MovieCircle
//
//  Created by zhouyongchao on 15/12/23.
//  Copyright (c) 2015年 dzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSecurity : NSObject

+ (NSString *)rasEncrypt:(NSString *)plainText;
+ (NSString *)rasDectypt:(NSString *)encryptText;

@end
