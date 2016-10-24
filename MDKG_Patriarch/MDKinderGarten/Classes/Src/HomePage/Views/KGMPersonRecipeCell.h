//
//  KGMPersonRecipeCell.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/10.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGMPersonRecipeCell;
@protocol KGMPersonRecipeCellDelegate <NSObject>

- (void)tableViewCell:(KGMPersonRecipeCell *)cell datePickerClicked:(UIDatePicker *)datePicker;

@end

@interface KGMPersonRecipeCell : UITableViewCell

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong, readwrite) UIDatePicker *inputView;
@property (nonatomic, strong, readwrite) UIToolbar *inputAccessoryView;
@property (nonatomic, weak) id<KGMPersonRecipeCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(NSInteger)type;

@end
