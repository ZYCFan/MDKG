//
//  KGMColleciontApi.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface KGMColleciontApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId topicId:(NSString *)topicId;

@end
