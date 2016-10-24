//
//  GTLoginOutService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTLoginOutService : NSObject

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *message;

- (void)loginOutWithUserId:(NSString *)userId success:(void(^)(GTLoginOutService *service))success failure:(void(^)(NSString *errorStr))failure;

@end
