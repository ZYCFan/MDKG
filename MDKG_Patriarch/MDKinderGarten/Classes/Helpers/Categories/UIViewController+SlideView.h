//
//  UIViewController+SlideView.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionAnimator.h"

@interface UIViewController (SlideView)<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) TransitionAnimator *transAnimator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIViewController *slideVC;

- (void)showSlideController:(UIViewController *)slideController;

@end
