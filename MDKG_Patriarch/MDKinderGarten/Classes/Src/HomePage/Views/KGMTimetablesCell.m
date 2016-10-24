//
//  KGMTimetablesCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/9.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMTimetablesCell.h"
#import "KGMWeekCourseDTO.h"

@interface KGMTimetablesCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblLesson;
@property (weak, nonatomic) IBOutlet UILabel *lblCourseName;
@property (weak, nonatomic) IBOutlet UILabel *lblCourseTime;

@end

@implementation KGMTimetablesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
- (void)setCourseData:(KGMWeekCourseData *)courseData {
    _courseData = courseData;
    
    self.lblLesson.text = courseData.sub_num;
    self.lblCourseName.text = courseData.sub_intro;
    self.lblCourseTime.text = courseData.sub_time;
}

@end
