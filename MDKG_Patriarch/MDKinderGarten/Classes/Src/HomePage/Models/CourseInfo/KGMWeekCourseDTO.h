//
//  KGMWeekCourseDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMWeekCourseDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@interface KGMWeekCourseData : NSObject

@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *sub_name;
@property (nonatomic, copy) NSString *sub_intro;
@property (nonatomic, copy) NSString *sub_time;
@property (nonatomic, copy) NSString *sub_num;

@end
