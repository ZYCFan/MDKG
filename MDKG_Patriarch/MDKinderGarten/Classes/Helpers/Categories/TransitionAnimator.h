//
//  TransitionAnimator.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypePresent,
    AnimationTypeDismiss
};

@interface TransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) AnimationType animationType;
@property (strong, nonatomic) UIView *layerView;

@end
