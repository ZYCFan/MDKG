//
//  KGMClassNoteDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/15.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@class KGMClassNoteData;
@interface KGMClassNoteDTO : BaseDTO

@property (nonatomic, strong) KGMClassNoteData *data;

@end

@interface KGMClassNoteData : NSObject

@property (nonatomic, copy) NSArray *class_notice;
@property (nonatomic, copy) NSString *page_count;

@end

@interface KGMClassNoteDetailData : NSObject

@property (nonatomic, copy) NSString *teacher_head;
@property (nonatomic, copy) NSString *teacher_name;
@property (nonatomic, copy) NSString *notice_id;
@property (nonatomic, copy) NSString *notice_title;
@property (nonatomic, copy) NSString *notice_intro;
@property (nonatomic, copy) NSString *notice_time;
@property (nonatomic, copy) NSString *notice_know;

@end
