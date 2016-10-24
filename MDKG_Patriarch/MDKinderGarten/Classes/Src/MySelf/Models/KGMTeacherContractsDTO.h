//
//  KGMTeacherContractsDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMTeacherContractsDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@interface KGMTeacherContractsData : NSObject

@property (nonatomic, copy) NSString *teacher_name;
@property (nonatomic, copy) NSString *teacher_mobile;

@end
