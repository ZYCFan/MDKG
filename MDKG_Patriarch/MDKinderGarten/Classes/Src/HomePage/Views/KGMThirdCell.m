//
//  KGMThirdCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMThirdCell.h"

@interface KGMThirdCell ()

@property (nonatomic, strong) UIView *containerV;
@property (nonatomic, strong) UILabel *lblWeather;
@property (nonatomic, strong) UILabel *lblAirQuality;
@property (nonatomic, assign) BOOL didSetupConstraint;

@end

@implementation KGMThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerV];
        [self.containerV addSubview:self.lblWeather];
        [self.containerV addSubview:self.lblAirQuality];
        self.backgroundColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraint) {
        @weakify(self);
        [self.containerV mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.contentView).offset(15 * KGScreenRatio);
            make.top.equalTo(self.contentView).offset(20 * KGScreenRatio);
            make.right.equalTo(self.contentView).offset(-15 * KGScreenRatio);
            make.bottom.equalTo(self.contentView).offset(-30 * KGScreenRatio);
        }];
        
        [self.lblWeather mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.containerV).offset(10 * KGScreenRatio);
            make.centerY.equalTo(self.containerV);
        }];
        
        [self.lblAirQuality mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lblWeather);
            make.left.equalTo(self.lblWeather.mas_right).offset(40 * KGScreenRatio);
        }];
        self.didSetupConstraint = YES;
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

#pragma mark - getter
- (UIView *)containerV {
    if (!_containerV) {
        _containerV = [[UIView alloc]init];
        _containerV.backgroundColor = HomePageBottomColor;
        _containerV.layer.cornerRadius = 5.f;
    }
    return _containerV;
}

- (UILabel *)lblWeather {
    if (!_lblWeather) {
        _lblWeather = [[UILabel alloc]init];
        _lblWeather.textColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
        _lblWeather.text = @"天气:";
    }
    return _lblWeather;
}

- (UILabel *)lblAirQuality {
    if (!_lblAirQuality) {
        _lblAirQuality = [[UILabel alloc]init];
        _lblAirQuality.textColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
        _lblAirQuality.text = @"空气质量:";
    }
    return _lblAirQuality;
}

#pragma mark - setter
- (void)setWeatherStr:(NSString *)weatherStr {
    _weatherStr = weatherStr;
    self.lblWeather.text = [NSString stringWithFormat:@"天气:%@",weatherStr];
}

- (void)setWeatherQuality:(NSString *)weatherQuality {
    _weatherQuality = weatherQuality;
    self.lblAirQuality.text = [NSString stringWithFormat:@"空气质量:%@",weatherQuality];
}

@end
