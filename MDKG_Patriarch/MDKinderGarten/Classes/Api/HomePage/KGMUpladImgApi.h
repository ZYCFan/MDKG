//
//  HomePageApi.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "YTKRequest.h"

@interface KGMUpladImgApi : YTKRequest

- (instancetype)initWithUserId:(NSString *)userId imgData:(NSData *)imgData;

@end
