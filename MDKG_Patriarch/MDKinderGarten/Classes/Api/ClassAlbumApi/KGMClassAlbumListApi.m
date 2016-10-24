//
//  KGMClassAlbumListApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassAlbumListApi.h"

@interface KGMClassAlbumListApi ()

@property (nonatomic, copy) NSString *classId;

@end

@implementation KGMClassAlbumListApi

- (instancetype)initWithClassId:(NSString *)classId {
    self = [super init];
    if (self) {
        _classId = [classId copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return ClassPhotoAlbumListUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"class_id":self.classId};
}

@end
