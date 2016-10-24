//
//  KGMSecCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMSecCell.h"

@implementation KGMSecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = HomePageBottomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClicked:(KGMClickButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:clickButton:)]) {
        [self.delegate tableViewCell:self clickButton:sender];
    }
}

@end
