//
//  KGMClassAlbumService.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassAlbumService.h"
#import "KGMClassAlbumListApi.h"

@interface KGMClassAlbumService ()

@property (nonatomic, strong) KGMClassAlbumListApi *listApi;

@end

@implementation KGMClassAlbumService

- (void)fetchClassAlbumListWithClassId:(NSString *)classId success:(successBlock)success failure:(errorBlock)failure {
    HTTPMSG_RELEASE_SAFELY(_listApi);
    
    self.listApi = [[KGMClassAlbumListApi alloc]initWithClassId:classId];
    [self.listApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        KGMClassAlbumListDTO *resultDTO = [KGMClassAlbumListDTO mj_objectWithKeyValues:request.responseJSONObject];
        if ([resultDTO.code isEqualToString:@"200"]) {
            success(resultDTO);
        } else {
            failure(resultDTO.message);
        }
        
    } failure:^(YTKBaseRequest *request) {
        failure(@"网络请求失败");
    }];
}

@end
