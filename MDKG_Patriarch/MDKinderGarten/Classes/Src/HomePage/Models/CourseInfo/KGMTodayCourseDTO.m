//
//  KGMTodayCourseDTO.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTodayCourseDTO.h"

@implementation KGMTodayCourseDTO

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"KGMTodayCourseData"};
}

@end

@implementation KGMTodayCourseData

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"task_content":@"KGMTodayCourseDetailData"};
}


@end

@implementation KGMTodayCourseDetailData

@end
