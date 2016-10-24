//
//  HomePageService.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/25.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "HomePageService.h"
#import "KGMUpladImgApi.h"

@interface HomePageService ()

@property (strong, nonatomic) KGMUpladImgApi *homePageApi;

@end

@implementation HomePageService

- (void)achieveBigCategory {
    HTTPMSG_RELEASE_SAFELY(self.homePageApi);
    self.homePageApi = [[KGMUpladImgApi alloc]init];
    [self.homePageApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"%ld",(long)request.responseStatusCode);
    }];
}

@end
