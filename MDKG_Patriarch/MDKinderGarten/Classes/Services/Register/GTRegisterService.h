//
//  GTRegisterService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTRegisterParams.h"

@interface GTRegisterService : NSObject

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *message;

- (void)takeCodeWithTel:(NSString *)telNumber success:(void (^)(GTRegisterService *service))success failure:(void(^)(NSString *errorStr))failure;
- (void)registerWithParams:(GTRegisterParams *)registerParams success:(void(^)(GTRegisterService *service))success failure:(void(^)(NSString *errorStr))failure;

@end
