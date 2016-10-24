//
//  DatabaseManager.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

DEF_SINGLETON(DatabaseManager);

@property (copy, nonatomic) NSString *writeTablePath;
@property (strong, nonatomic) FMDatabaseQueue *dataBaseQueue;
@property (assign, nonatomic,getter=isDataBaseOpened) BOOL dataBaseOpen;

- (void)openDataBase;
- (void)closeDataBase;

@end
