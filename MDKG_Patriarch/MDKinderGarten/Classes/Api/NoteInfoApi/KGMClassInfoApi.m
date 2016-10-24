//
//  KGMClassInfoApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassInfoApi.h"

@interface KGMClassInfoApi ()

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *pageCount;

@end

@implementation KGMClassInfoApi

- (instancetype)initWithUserId:(NSString *)userId classId:(NSString *)classId currentPage:(NSString *)currentPage pageCount:(NSString *)pageCount {
    self = [super init];
    if (self) {
        _userId = [userId copy];
        _classId = [classId copy];
        _currentPage = [currentPage copy];
        _pageCount = [pageCount copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return ClassNoteUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"student_id":self.userId,
             @"class_id":self.classId,
             @"nowPage":self.currentPage,
             @"pageSize":self.pageCount
             };
}

@end
