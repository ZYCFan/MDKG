//
//  KGMTodayCourseSectionView.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/10.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGTodayCourseSectionViewDelegate <NSObject>

- (void)sectionView:(UIView *)view buttonClicked:(UIButton *)sender;

@end

@class KGMTodayCourseData;
@interface KGMTodayCourseSectionView : UIView

@property (nonatomic, assign) id<KGTodayCourseSectionViewDelegate> delegate;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSArray *courseDataArr;//先设置courseDataArr,再设置count

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;
- (CGFloat)calculateHeight;

@end
