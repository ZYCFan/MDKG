//
//  DatabaseDAO.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "DatabaseDAO.h"
#import "DatabaseManager.h"

@implementation DatabaseDAO

+ (void)createTablesIfNeeded {
    @autoreleasepool {
        FMDatabaseQueue *databaseQueue = [DatabaseManager sharedInstance].dataBaseQueue;
        [databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            NSString *createUserInfoSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS D_userinfo (useinfo_id INTEGER PRIMARY KEY NOT NULL,is_login TEXT NOT NULL,login_name TEXT,app_start_time TEXT NOT NULL,app_stop_time TEXT NOT NULL)"];
            [db executeUpdate:createUserInfoSql];
        }];
    }
}

@end
