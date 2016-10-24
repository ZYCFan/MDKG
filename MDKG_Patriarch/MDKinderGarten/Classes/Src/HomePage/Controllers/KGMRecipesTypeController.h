//
//  KGMRecipesTypeController.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/18.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "PageRefreshController.h"

typedef void(^dismissBlock)(NSString *str);
@interface KGMRecipesTypeController : PageRefreshController

- (instancetype)initWithBlock:(dismissBlock)block;

@end
