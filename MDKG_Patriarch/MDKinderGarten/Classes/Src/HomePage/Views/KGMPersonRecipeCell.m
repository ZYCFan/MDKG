//
//  KGMPersonRecipeCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/10.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMPersonRecipeCell.h"

@interface KGMPersonRecipeCell ()

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation KGMPersonRecipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(NSInteger)type {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (type == 1) {
            [self.contentView addSubview:self.textView];
            [self setNeedsUpdateConstraints];
        }
        _type = type;
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints && self.type == 1) {
        @weakify(self);
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.contentView);
        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15.f;
    frame.origin.y += 5.f;
    frame.size.width -= 30.f;
    frame.size.height -= 10.f;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 5.f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setting PickerView
- (BOOL)canBecomeFirstResponder {
    if (self.type == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - private methods
- (void)cancleAction:(UIBarButtonItem *)sender {
    [self resignFirstResponder];
}

- (void)sureAction:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:datePickerClicked:)]) {
        [self.delegate tableViewCell:self datePickerClicked:self.inputView];
    }
}

#pragma mark - getter
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
    }
    return _textView;
}

- (UIDatePicker *)inputView {
    if (!_inputView && self.type == 0) {
        _inputView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
        _inputView.datePickerMode = UIDatePickerModeDate;
    }
    return _inputView;
}

- (UIToolbar *)inputAccessoryView {
    if (!_inputAccessoryView && self.type == 0) {
        _inputAccessoryView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction:)];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];
        
        _inputAccessoryView.items = @[leftItem,flexItem,rightItem];
    }
    return _inputAccessoryView;
}

@end
