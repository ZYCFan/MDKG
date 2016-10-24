//
//  HomePageApi.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMUpladImgApi.h"

@interface KGMUpladImgApi ()

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) NSData *imgData;

@end

@implementation KGMUpladImgApi

- (instancetype)initWithUserId:(NSString *)userId imgData:(NSData *)imgData {
    self = [super init];
    if (self) {
        _userId = [userId copy];
        _imgData = imgData;
    }
    return self;
}

- (NSString *)requestUrl {
    return UploadHeadImageUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"student_id":self.userId,
             };
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:self.imgData name:@"student_head" fileName:@"student_head.png" mimeType:@"image/jpeg"];
    };
}

@end
