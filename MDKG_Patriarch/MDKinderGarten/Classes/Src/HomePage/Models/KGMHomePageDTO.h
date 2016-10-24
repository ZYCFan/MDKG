//
//  KGMHomePageDTO.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/14.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "BaseDTO.h"

@class KGMHomePageData;
@interface KGMHomePageDTO : BaseDTO

@property (nonatomic, strong) KGMHomePageData *data;

@end

@class KGMWeatherData;
@interface KGMHomePageData : NSObject

@property (nonatomic, strong) KGMWeatherData *weather;
@property (nonatomic, copy) NSArray *topic;

@end

@interface KGMWeatherData : NSObject

@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *air;

@end

@interface KGMTopicData : NSObject

@property (nonatomic, copy) NSString *topic_id;
@property (nonatomic, copy) NSString *topic_type;
@property (nonatomic, copy) NSString *topic_title;
@property (nonatomic, copy) NSString *topic_img;
@property (nonatomic, copy) NSString *topic_intro;
@property (nonatomic, copy) NSString *topic_collection_num;
@property (nonatomic, copy) NSString *topic_collection;

@end
