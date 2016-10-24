//
//  GTLoginApi.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/5.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface GTLoginApi : YTKRequest

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password;

@end
