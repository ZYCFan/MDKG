//
//  DatabaseManager.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/26.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "DatabaseManager.h"
static NSString *const DataBaseFileName = @"database.sqlite";
@interface DatabaseManager ()

@property (copy, nonatomic) NSString *dataBaseDirectory;

@end

@implementation DatabaseManager
IMP_SINGLETON(DatabaseManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataBaseOpen = NO;
        self.writeTablePath = [self.dataBaseDirectory stringByAppendingPathComponent:DataBaseFileName];
        
    }
    return self;
}

- (void)openDataBase {
    self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.writeTablePath];
    if (self.dataBaseQueue == 0x00) {
        self.dataBaseOpen = NO;
        return;
    }
    self.dataBaseOpen = YES;
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db setShouldCacheStatements:YES];
    }];
}

- (void)closeDataBase {
    if (!self.isDataBaseOpened) {
        return;
    } else {
        [self.dataBaseQueue close];
        self.dataBaseOpen = NO;
    }
}

#pragma mark - getter
- (NSString *)dataBaseDirectory {
    if (!_dataBaseDirectory) {
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _dataBaseDirectory = [[[cacheDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"Database"] copy];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_dataBaseDirectory isDirectory:&isDirectory];
        if (!isExist) {
            [fileManager createDirectoryAtPath:_dataBaseDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    return _dataBaseDirectory;
}

@end
