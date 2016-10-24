//
//  KGMRecipesCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/9.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMRecipesCell.h"
#import "KGMWeekRecipesDTO.h"
#import "UIImageView+WebCache.h"

@interface KGMRecipesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;


@end

@implementation KGMRecipesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}


- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15.f;
    frame.size.width -= 30.f;
    frame.origin.y += 5.f;
    frame.size.height -= 10.f;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
- (void)setData:(KGMWeekRecipesData *)data {
    _data = data;
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:data.img ?: @""] placeholderImage:nil];
    self.lblTitle.text = data.name;
    self.lblContent.text = data.intro;
}

@end
