//
//  RegisterView.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/5/4.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterFootViewDelegate <NSObject>

- (void)registerClicked:(UIButton *)sender;

@end

@interface RegisterFootView : UIView

@property (nonatomic, weak) id<RegisterFootViewDelegate> delegate;

@end
