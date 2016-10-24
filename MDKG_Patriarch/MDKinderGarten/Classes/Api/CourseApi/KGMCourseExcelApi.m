//
//  KGMCourseExcelApi.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMCourseExcelApi.h"

@interface KGMCourseExcelApi ()

@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *weekDay;

@end

@implementation KGMCourseExcelApi

- (instancetype)initWithClassId:(NSString *)classId weekDay:(NSString *)weekDay {
    self = [super init];
    if (self) {
        _classId = [classId copy];
        _weekDay = [weekDay copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return CourseExcelUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{@"class_id":self.classId,
             @"week":self.weekDay};
}

@end
