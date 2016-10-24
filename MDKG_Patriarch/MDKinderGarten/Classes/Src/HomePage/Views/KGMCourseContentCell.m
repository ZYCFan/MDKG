//
//  KGMCourseContentCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/11.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMCourseContentCell.h"
#import "KGMTodayCourseDTO.h"
#import "UIImageView+WebCache.h"

@interface KGMCourseContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;

@end

@implementation KGMCourseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5.f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.masksToBounds = YES;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15.f;
    frame.origin.y += 5.f;
    frame.size.width -= 30.f;
    frame.size.height -= 10.f;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
- (void)setDetailData:(KGMTodayCourseDetailData *)detailData {
    _detailData = detailData;
    self.lblTitle.text = detailData.task_intro;
    
    if (detailData.task_image) {
        [self.imgContent sd_setImageWithURL:[NSURL URLWithString:detailData.task_image] placeholderImage:[UIImage imageNamed:@"zuoye_img_1"]];
    }
    
}

@end
