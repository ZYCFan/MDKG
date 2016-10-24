//
//  KGMMySelfTopCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMMySelfTopCell.h"
#import "KGMMySelfCircleHeadImage.h"

@interface KGMMySelfTopCell ()

@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) KGMMySelfCircleHeadImage *headImage;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation KGMMySelfTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.headImage];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        @weakify(self);
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, -1, 0));
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]initWithImage:VERSION_MAN ? GlobalImage_MAN : GlobalImage_Female];
    }
    return _bottomView;
}

- (KGMMySelfCircleHeadImage *)headImage {
    if (!_headImage) {
        _headImage = [[KGMMySelfCircleHeadImage alloc]initWithFrame:CGRectMake(kDeviceWidth - (50 + 30) * KGScreenRatio, (100 - 50 - 30) * KGScreenRatio, 52 * KGScreenRatio, 52 * KGScreenRatio)];
    }
    return _headImage;
}

#pragma mark - setter
- (void)setHeadImgUrl:(NSString *)headImgUrl {
    _headImgUrl = headImgUrl;
    self.headImage.imgUrl = headImgUrl;
}

@end
