//
//  KGMTimetablesCell.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/9.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGMWeekCourseData;
@interface KGMTimetablesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (nonatomic, strong) KGMWeekCourseData *courseData;

@end
