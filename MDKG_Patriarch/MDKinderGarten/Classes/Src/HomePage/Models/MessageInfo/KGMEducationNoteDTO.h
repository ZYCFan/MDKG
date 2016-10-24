//
//  KGMEducationNoteDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@class KGMEducationNoteData;
@interface KGMEducationNoteDTO : BaseDTO

@property (nonatomic, strong) KGMEducationNoteData *data;

@end

@interface KGMEducationNoteData : NSObject

@property (nonatomic, copy) NSArray *edu_notice;
@property (nonatomic, copy) NSString *page_count;

@end

@interface KGMEducationNoteDetailData : NSObject

@property (nonatomic, copy) NSString *edu_title;
@property (nonatomic, copy) NSString *edu_intro;
@property (nonatomic, copy) NSString *edu_url;

@end
