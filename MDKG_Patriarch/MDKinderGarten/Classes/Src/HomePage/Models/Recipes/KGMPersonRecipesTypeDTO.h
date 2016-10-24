//
//  KGMPersonRecipesTypeDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMPersonRecipesTypeDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@interface KGMPersonRecipesTypeData : NSObject

@property (nonatomic, copy) NSString *type;

@end
