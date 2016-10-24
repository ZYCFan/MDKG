//
//  KGMKnowClassNoteApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMKnowClassNoteApi.h"

@interface KGMKnowClassNoteApi ()

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *noteId;

@end

@implementation KGMKnowClassNoteApi

- (instancetype)initWithUserId:(NSString *)userId noteId:(NSString *)noteId {
    self = [super init];
    if (self) {
        _userId = [userId copy];
        _noteId = [noteId copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return KnowClassNoteUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"student_id":self.userId,
             @"notice_id":self.noteId};
}

@end
