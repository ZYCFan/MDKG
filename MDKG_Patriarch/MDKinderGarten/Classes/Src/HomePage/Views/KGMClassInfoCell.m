//
//  KGMClassInfoCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/8.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassInfoCell.h"
#import "KGMClassNoteDTO.h"
#import "UIImageView+WebCache.h"

@interface KGMClassInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UIButton *btnKnow;
@property (weak, nonatomic) IBOutlet UILabel *lblTeacherName;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation KGMClassInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnKnow.layer.cornerRadius = 5.f;
}


- (void)updateConstraints {
    [self.leftImgV layoutIfNeeded];
    [super updateConstraints];
    self.leftImgV.layer.cornerRadius = CGRectGetWidth(self.leftImgV.bounds) / 2.0f;
    self.leftImgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnKnowClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(btnKnowClicked:indexPath:)]) {
        [self.delegate btnKnowClicked:sender indexPath:self.indexPath];
    }
}

#pragma mark - setter
- (void)setDetailData:(KGMClassNoteDetailData *)detailData {
    _detailData = detailData;
    if (detailData.teacher_head) {
        [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:detailData.teacher_head] placeholderImage:nil];
    }
    
    self.lblTeacherName.text = detailData.teacher_name;
    self.lblContent.text = detailData.notice_intro;
    self.lblTime.text = detailData.notice_time;
    if ([detailData.notice_know isEqualToString:@"0"]) {
        self.btnKnow.backgroundColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
        self.btnKnow.enabled = YES;
    } else {
        self.btnKnow.backgroundColor = [UIColor lightGrayColor];
        self.btnKnow.enabled = NO;
    }
}

@end
