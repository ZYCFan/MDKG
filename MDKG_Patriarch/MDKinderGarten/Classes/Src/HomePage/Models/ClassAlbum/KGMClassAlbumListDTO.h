//
//  KGMClassAlbumListDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@interface KGMClassAlbumListDTO : BaseDTO

@property (nonatomic, copy) NSArray *data;

@end

@interface KGMClassAlbumListData : NSObject

@property (nonatomic, copy) NSString *simg;
@property (nonatomic, copy) NSString *bimg;

@end
