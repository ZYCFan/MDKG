//
//  KGMEducationInfoCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/8.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMEducationInfoCell.h"
#import "KGMEducationNoteDTO.h"

@interface KGMEducationInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation KGMEducationInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.origin.y += 5;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
- (void)setDetailData:(KGMEducationNoteDetailData *)detailData {
    _detailData = detailData;
    self.lblTitle.text = detailData.edu_title;
    self.lblContent.text = detailData.edu_intro;
}

@end
