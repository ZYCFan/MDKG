//
//  KGMForthCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMForthCell.h"
#import "KGMHomePageDTO.h"
#import "UIImageView+WebCache.h"

@interface KGMForthCell ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *lblHot;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *lblShowAll;
@property (nonatomic, strong) UIButton *btnComment;
@property (nonatomic, strong) UIButton *btnCollection;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation KGMForthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.mainView];
        [self.contentView addSubview:self.bottomView];
        
        [self.topView addSubview:self.lblHot];
        [self.topView addSubview:self.lblTitle];
        
        [self.mainView addSubview:self.contentImage];

        [self.bottomView addSubview:self.lblShowAll];
//        [self.bottomView addSubview:self.btnComment];
        [self.bottomView addSubview:self.btnCollection];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        @weakify(self);
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.top.right.equalTo(self.contentView);
            make.height.mas_equalTo(40 * KGScreenRatio);
        }];
        
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.equalTo(self.topView);
            make.top.equalTo(self.topView.mas_bottom);
            make.height.mas_equalTo(190 * KGScreenRatio);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.right.equalTo(self.mainView);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(40 *KGScreenRatio);
        }];
        
        [self.lblHot mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.topView).offset(15 * KGScreenRatio);
            make.top.equalTo(self.topView).offset(8 * KGScreenRatio);
            make.bottom.equalTo(self.topView).offset(-8 * KGScreenRatio);
            make.width.equalTo(self.lblHot.mas_height).multipliedBy(1.8);
        }];
        
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.lblHot);
            make.left.equalTo(self.lblHot.mas_right).offset(10);
            make.right.equalTo(self.topView);
        }];
        
        [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.mainView);
        }];
        
        [self.lblShowAll mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView).offset(15 * KGScreenRatio);
        }];
        
        [self.btnCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.lblShowAll);
            make.right.equalTo(self.bottomView).offset(-15 * KGScreenRatio);
        }];
        
//        [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self);
//            make.centerY.equalTo(self.lblShowAll);
//            make.right.equalTo(self.btnCollection.mas_left).offset(-35 * KGScreenRatio);
//        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15.f;
    frame.size.width -= 30.f;
    
    frame.origin.y += 12.5f;
    frame.size.height -= 25.f;
    [super setFrame:(CGRect)frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - private method
- (void)collectionClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickCollectionWithButton:indexPath:)]) {
        [self.delegate clickCollectionWithButton:sender indexPath:self.indexPath];
    }
}

#pragma mark - getter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
    }
    return _mainView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

- (UILabel *)lblHot {
    if (!_lblHot) {
        _lblHot = [[UILabel alloc]init];
        _lblHot.textAlignment = NSTextAlignmentCenter;
        _lblHot.layer.cornerRadius = 2.f;
        _lblHot.layer.masksToBounds = YES;
        _lblHot.font = [UIFont systemFontOfSize:13];
        _lblHot.textColor = [UIColor whiteColor];
    }
    return _lblHot;
}

- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
    }
    return _lblTitle;
}

- (UIImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc]init];
    }
    return _contentImage;
}

- (UILabel *)lblShowAll {
    if (!_lblShowAll) {
        _lblShowAll = [[UILabel alloc]init];
        _lblShowAll.text = @"查看全文";
        _lblShowAll.textColor = [UIColor lightGrayColor];
    }
    return _lblShowAll;
}

- (UIButton *)btnComment {
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.userInteractionEnabled = NO;
        [_btnComment setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_btnComment setTitle:@"210" forState:UIControlStateNormal];
        [_btnComment setTitleColor:VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female forState:UIControlStateNormal];
    }
    return _btnComment;
}

- (UIButton *)btnCollection {
    if (!_btnCollection) {
        _btnCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCollection setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
//        [_btnCollection setTitle:@"168" forState:UIControlStateNormal];
        [_btnCollection setTitleColor:VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female forState:UIControlStateNormal];
        [_btnCollection addTarget:self action:@selector(collectionClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCollection;
}

#pragma mark - setter
- (void)setTopicData:(KGMTopicData *)topicData {
    _topicData = topicData;
    self.lblHot.text = topicData.topic_type;
    self.lblTitle.text = topicData.topic_title;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:topicData.topic_img] placeholderImage:[UIImage imageNamed:@"news_demo"]];
    [self.btnCollection setTitle:topicData.topic_collection_num forState:UIControlStateNormal];
    
    if ([topicData.topic_collection isEqualToString:@"1"]) {
        [self.btnCollection setImage:[UIImage imageNamed:@"favorites_2"] forState:UIControlStateNormal];
    } else {
        [self.btnCollection setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    NSArray *colorArr = @[Color_RGB(252, 129, 149, 1),Color_RGB(82, 217, 182, 1),Color_RGB(117, 212, 253, 1)];
    self.lblHot.backgroundColor = colorArr[indexPath.row % 3];
}

@end
