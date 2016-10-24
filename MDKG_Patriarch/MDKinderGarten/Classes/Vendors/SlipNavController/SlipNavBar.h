//
//  SlipNavBar.h
//  SlipNavController
//
//  Created by apple on 15-4-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LEFT_VIEW_WIDTH 60
#define RIGHT_VIEW_WIDTH 50
#define TAB_BAR_Y 0
#define DOT_COORDINATE 0
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define STATUS_BAR_HEIGHT 20

@protocol SlipNavBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;


- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height;

@end

@interface SlipNavBar : UIView

@property (nonatomic, weak) id <SlipNavBarDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;           // 当前被选择索引值
@property (nonatomic, strong)   NSArray     *itemTitles;                // 所有控制器title
@property (nonatomic, strong)   UIColor     *lineColor;
@property (nonatomic, strong)   UIView     *rightViewToShow;           

- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)view;
- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)view;
- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)view andRightView:(UIView *)rightView;
- (void)selectAtIndex:(NSInteger)index;

@end
