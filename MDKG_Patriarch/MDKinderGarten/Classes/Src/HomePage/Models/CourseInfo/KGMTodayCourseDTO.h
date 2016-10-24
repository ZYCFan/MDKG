//
//  KGMTodayCourseDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMTodayCourseDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@class KGMTodayCourseDetailData;
@interface KGMTodayCourseData : NSObject

@property (nonatomic, copy) NSString *task_name;
@property (nonatomic, copy) NSString *task_have;
@property (nonatomic, copy) NSArray *task_content;

@end

@interface KGMTodayCourseDetailData : NSObject

@property (nonatomic, copy) NSString *task_intro;
@property (nonatomic, copy) NSString *task_image;

@end
