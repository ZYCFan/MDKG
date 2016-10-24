//
//  KGMEducationInfoApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMEducationInfoApi.h"

@interface KGMEducationInfoApi ()

@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *pageCount;

@end

@implementation KGMEducationInfoApi

- (instancetype)initWithCurrentPage:(NSString *)currentPage pageCount:(NSString *)pageCount {
    self = [super init];
    if (self) {
        _currentPage = [currentPage copy];
        _pageCount = [pageCount copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return EducationNoteUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"nowPage":self.currentPage,
             @"pageSize":self.pageCount};
}

@end
