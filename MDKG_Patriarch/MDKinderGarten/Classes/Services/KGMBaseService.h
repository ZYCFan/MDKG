//
//  KGMBaseService.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock) (id data);
typedef void(^errorBlock) (NSString *errorStr);
@interface KGMBaseService : NSObject

@end
