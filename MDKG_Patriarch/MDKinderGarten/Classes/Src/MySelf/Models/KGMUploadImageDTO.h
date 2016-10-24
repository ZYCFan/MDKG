//
//  KGMUploadImageDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/21.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@class KGMUploadImageData;
@interface KGMUploadImageDTO : BaseDTO

@property (nonatomic, strong) KGMUploadImageData *data;

@end

@interface KGMUploadImageData : NSObject

@property (nonatomic, copy) NSString *head_url;

@end
