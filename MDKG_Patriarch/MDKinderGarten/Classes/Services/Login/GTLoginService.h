//
//  GTLoginService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLoginDTO.h"

@interface GTLoginService : NSObject

- (void)loginWithParams:(GTLoginParams *)params success:(void(^)(GTLoginService *service))success failure:(void(^)(NSString *errorStr))failure;

@end
