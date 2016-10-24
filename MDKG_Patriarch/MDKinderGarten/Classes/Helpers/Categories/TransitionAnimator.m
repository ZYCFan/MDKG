//
//  TransitionAnimator.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "TransitionAnimator.h"
static const char *AnimationTypeKey = "animationTypeKey";

#define Switch_Time  0.5
@implementation TransitionAnimator

- (void)setAnimationType:(AnimationType)animationType {
    NSNumber *number = [NSNumber numberWithInteger:animationType];
    objc_setAssociatedObject(self, AnimationTypeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLayerView:(UIView *)layerView {
    objc_setAssociatedObject(self, @selector(layerView), layerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AnimationType)animationType {
    return [objc_getAssociatedObject(self, AnimationTypeKey) integerValue];
}

- (UIView *)layerView {
    return objc_getAssociatedObject(self, @selector(layerView));
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return Switch_Time;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    
    if (!self.layerView) {
        UIView *layerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        layerV.backgroundColor = [UIColor blackColor];
        layerV.alpha = 0.0f;
        [self setLayerView:layerV];
    }
    
    
    CGFloat viewX = 70 * ratio;
    CGFloat viewW = kDeviceWidth - viewX;
    if (self.animationType == AnimationTypeDismiss) {
        UIView *snap = [fromView snapshotViewAfterScreenUpdates:YES];
        fromView.frame = CGRectMake(kDeviceWidth, 0, viewW, kDeviceHeight);
        
        [[transitionContext containerView] addSubview:snap];
        snap.frame = CGRectMake(viewX, 0, viewW, kDeviceHeight);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            self.layerView.alpha = 0.0f;
            snap.frame = CGRectMake(kDeviceWidth, 0, viewW, kDeviceHeight);
        } completion:^(BOOL finished) {
            [snap removeFromSuperview];
            fromView.frame = snap.frame;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        UIView *snap = [toView snapshotViewAfterScreenUpdates:YES];
        snap.frame = CGRectMake(kDeviceWidth, 0, viewW, kDeviceHeight);
        [[transitionContext containerView] addSubview:self.layerView];
        [[transitionContext containerView] addSubview:snap];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            self.layerView.alpha = 0.5f;
            snap.frame = CGRectMake(viewX, 0, kDeviceWidth, kDeviceHeight);
        } completion:^(BOOL finished) {
            toView.frame = snap.frame;
            [snap removeFromSuperview];
            [[transitionContext containerView] addSubview:toView];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
