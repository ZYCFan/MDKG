//
//  SlipNavBar.m
//  SlipNavController
//
//  Created by apple on 15-4-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SlipNavBar.h"



#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define STATUS_BAR_HEIGT 20
#define STATUS_BAR_HEIGHT 20
#define NAV_BAR_HEIGHT 45

#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]



@interface SlipNavBar () <SlipNavBarDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *navTabBar;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *leftView;

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSArray *itemsWidth;
@property (nonatomic, assign, getter = isShowRightView) BOOL showRightView;
@property (nonatomic, assign, getter = isShowLeftView) BOOL showLeftView;
@property (strong, nonatomic) UIButton *selectedBtn;
@property (assign, nonatomic)  CGFloat itemsSumWidth;
@property (assign, nonatomic)  CGFloat buttonMargin;

@property (nonatomic, assign, getter = isLongEnough) BOOL longEnough;

@end

@implementation SlipNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _showRightView = NO;
        _showLeftView = NO;
        [self initConfig];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame rightView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _rightView = view;
        _showRightView = YES;
        _showLeftView = NO;
        [self initConfig];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _leftView = view;
        _showLeftView = YES;
        _showRightView = NO;
        [self initConfig];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)view andRightView:(UIView *)rightView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _leftView = view;
        _rightView = view;
        _showLeftView = YES;
        _showRightView = YES;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    [self viewConfig];
}


- (void)viewConfig
{
    if (_leftView != nil && _rightView == nil) { // 仅有左
        _leftView.frame = CGRectMake(DOT_COORDINATE, TAB_BAR_Y, LEFT_VIEW_WIDTH, NAV_BAR_HEIGHT);
        // navgation item 位置
        _navTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame), TAB_BAR_Y, self.frame.size.width - LEFT_VIEW_WIDTH, NAV_BAR_HEIGHT)];
        _navTabBar.showsHorizontalScrollIndicator = NO;
        _navTabBar.bounces = NO;
        [self addSubview:_navTabBar];
        [self addSubview:_leftView];
    } else if (_leftView == nil && _rightView != nil) { // 仅有右
        _rightView.frame = CGRectMake(SCREEN_WIDTH - RIGHT_VIEW_WIDTH, TAB_BAR_Y, RIGHT_VIEW_WIDTH, NAV_BAR_HEIGHT);
        // navgation item 位置
        _navTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, TAB_BAR_Y, self.frame.size.width - RIGHT_VIEW_WIDTH, NAV_BAR_HEIGHT)];
        _navTabBar.showsHorizontalScrollIndicator = NO;
        _navTabBar.bounces = NO;
        [self addSubview:_navTabBar];
        [self addSubview:_rightView];
    } else if  (_rightView != nil && _leftView != nil) { // 左右都有
        
        _leftView.frame = CGRectMake(DOT_COORDINATE, TAB_BAR_Y, LEFT_VIEW_WIDTH, NAV_BAR_HEIGHT);
        // navgation item 位置
        _navTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame), TAB_BAR_Y, self.frame.size.width - LEFT_VIEW_WIDTH - RIGHT_VIEW_WIDTH, NAV_BAR_HEIGHT)];
        _rightView.frame = CGRectMake(CGRectGetMaxX(_navTabBar.frame), TAB_BAR_Y, RIGHT_VIEW_WIDTH, NAV_BAR_HEIGHT);
        _navTabBar.showsHorizontalScrollIndicator = NO;
        _navTabBar.bounces = NO;
        [self addSubview:_navTabBar];
        [self addSubview:_leftView];
        [self addSubview:_rightView];
    } else { // 左右都没有
        
        // navgation item 位置
        _navTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, TAB_BAR_Y, self.frame.size.width, NAV_BAR_HEIGHT)];
        _navTabBar.showsHorizontalScrollIndicator = NO;
        _navTabBar.bounces = NO;
        [self addSubview:_navTabBar];
    }

}
- (CGFloat)buttonMargin
{
    _buttonMargin = 0;
    if (!self.longEnough) {
        _buttonMargin = ( _navTabBar.frame.size.width - self.itemsSumWidth) / (_itemsWidth.count + 1);
    }
    return _buttonMargin;
}
- (BOOL)isLongEnough
{
    return self.itemsSumWidth > _navTabBar.frame.size.width ? YES:NO;
}

/**
 *  添加阴影
 */
- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOffset = CGSizeMake(-1, 0);
//    view.layer.
    view.layer.shadowOpacity = shadowOpacity;
}


/**
 *  自控制器title按钮被点击
 *
 *  @param button 被点击的按钮
 */
- (void)itemPressed:(UIButton *)button
{

    self.currentItemIndex = [_items indexOfObject:button];
    if ([_delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]){
        [_delegate itemDidSelectedWithIndex:self.currentItemIndex];
    }
}
- (void)selectAtIndex:(NSInteger)index
{
    if (index > _itemTitles.count) return;
    UIButton *btn = (UIButton *)[_items objectAtIndex:index];
    [self itemPressed:btn];
}
/**
 *   通过自控制器的标题数组，计算自控制器标题宽度数组
 *
 *  @param titles 标题数组，外部传入
 *
 *  @return 每个标题宽度 所组成的数组
 */
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
        textAttr[NSFontAttributeName] = TITLE_FONT;
        CGSize size = [title sizeWithAttributes:textAttr];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 20];
        [widths addObject:width];
    }
    
    return widths;
}
- (void)setItemTitles:(NSArray *)itemTitles
{
    _itemTitles = itemTitles;
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
//        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
//        _navTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
        [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navTabBar.contentSize = CGSizeMake(kDeviceWidth, DOT_COORDINATE);
    }
}

- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    
//    CGFloat buttonX = self.buttonMargin;
    CGFloat buttonX = 0.f;
    CGFloat buttonY = 0.f;
    CGFloat buttonW = kDeviceWidth / 2.f;
    
    for (NSInteger index = 0; index < _itemTitles.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(buttonX, 0, [widths[index] floatValue], NAV_BAR_HEIGHT);
        button.frame = CGRectMake(buttonX + index * buttonW, buttonY, buttonW, NAV_BAR_HEIGHT);

        button.titleLabel.font = TITLE_FONT;
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:self.lineColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchDown];
        [_navTabBar addSubview:button];
        
        [_items addObject:button];

//        buttonX += [widths[index] floatValue] + self.buttonMargin;

    }
//    [self itemPressed:_items[0]];
    self.currentItemIndex = 0;
    // 显示底部 蓝色 横线
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
}
- (CGFloat)itemsSumWidth
{
    CGFloat sumWidth = 0;
    for (int i = 0; i < _itemsWidth.count; i++) {
        sumWidth += [_itemsWidth[i] floatValue];
    }
    return sumWidth;
}
- (void)showLineWithButtonWidth:(CGFloat)width
{
//    _line = [[UIView alloc] initWithFrame:CGRectMake(self.buttonMargin, NAV_BAR_HEIGHT - 3.0f, width - 4.0f, 3.0f)];
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT - 3.0f, kDeviceWidth / self.itemTitles.count, 3.0f)];
    _line.backgroundColor = self.lineColor;
    [_navTabBar addSubview:_line];
}
- (void)updateData
{
    
}

/**
 *  Refresh All Subview
 */
- (void)refresh
{
    
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;

    CGFloat flag;
    if (_showRightView && !_showLeftView)
    {
        flag = SCREEN_WIDTH - RIGHT_VIEW_WIDTH;
    } else if (!_showRightView && _showLeftView) {
     
        flag = SCREEN_WIDTH - LEFT_VIEW_WIDTH;
    } else if  (_showLeftView && _showRightView) {
        flag = SCREEN_WIDTH - RIGHT_VIEW_WIDTH - LEFT_VIEW_WIDTH;
    } else {
        flag = SCREEN_WIDTH;
    }

    CGFloat offsetX = _navTabBar.contentOffset.x;
    CGFloat maxOffsetX = CGRectGetMaxX(button.frame) - _navTabBar.contentOffset.x;
    CGFloat rightOverlap = maxOffsetX - flag;
    CGFloat leftOverlap = _navTabBar.contentOffset.x - button.frame.origin.x;
    if (maxOffsetX > flag)
    {
        offsetX += rightOverlap;
    }
    if (button.frame.origin.x < _navTabBar.contentOffset.x) {
       offsetX -= leftOverlap;
    }
    [_navTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    [UIView animateWithDuration:0.2f animations:^{
//        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue] - 4.0f, _line.frame.size.height);
        
        _line.frame = CGRectMake(button.frame.origin.x, _line.frame.origin.y, button.frame.size.width, _line.frame.size.height);
    }];

}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _line.backgroundColor = lineColor;
}

@end
