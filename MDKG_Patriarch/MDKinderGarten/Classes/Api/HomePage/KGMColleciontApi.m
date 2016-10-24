//
//  KGMColleciontApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMColleciontApi.h"

@interface KGMColleciontApi ()

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *topicId;

@end

@implementation KGMColleciontApi

- (instancetype)initWithUserId:(NSString *)userId topicId:(NSString *)topicId {
    self = [super init];
    if (self) {
        _userId = [userId copy];
        _topicId = [topicId copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return CollectionUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"student_id":self.userId,
             @"topic_id":self.topicId};
}


@end
