//
//  KGMWeekView.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/8.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGMWeekView;
@protocol KGMWeekViewDelegate <NSObject>

- (void)view:(KGMWeekView *)view clickDayButton:(UIButton *)sender;

@end

@interface KGMWeekView : UIView

@property (nonatomic, weak) id<KGMWeekViewDelegate> delegate;

@end
