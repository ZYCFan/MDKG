//
//  GTRegisterParams.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTRegisterParams : NSObject

@property (nonatomic, copy) NSString *userTel;
@property (nonatomic, copy) NSString *userPassword;
@property (nonatomic, copy) NSString *userCode;

- (instancetype)initWithUserTel:(NSString *)userTel password:(NSString *)password code:(NSString *)code;

@end
