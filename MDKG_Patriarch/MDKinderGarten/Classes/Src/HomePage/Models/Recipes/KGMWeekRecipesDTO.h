//
//  KGMWeekRecipesDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/17.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMWeekRecipesDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@interface KGMWeekRecipesData : NSObject

@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *img;

@end
