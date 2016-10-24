//
//  LoginCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/12.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()

@property (nonatomic, strong) NSArray *leftImageArr;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation LoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textField];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        @weakify(self);
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(15 * KGScreenRatio, 40 * KGScreenRatio, 15 * KGScreenRatio, 40 * KGScreenRatio));
        }];
        [self.textField layoutIfNeeded];
        
        self.textField.layer.masksToBounds = YES;
        self.textField.layer.cornerRadius = CGRectGetHeight(self.textField.frame) / 2.0f;
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (NSArray *)leftImageArr {
    if (!_leftImageArr) {
        _leftImageArr = @[@"login_icon1",@"login_icon2"];
    }
    return _leftImageArr;
}

#pragma mark- setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.leftImageArr[indexPath.row - 1]]];
    imgV.frame = CGRectMake(20, 0, 47, 30 * KGScreenRatio);
    imgV.contentMode = UIViewContentModeCenter;
    _textField.leftView = imgV;
}

@end
