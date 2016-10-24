//
//  DatabaseDAO.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseDAO : NSObject
/**
 *  创建需要的数据库表
 */
+ (void)createTablesIfNeeded;

@end
