//
//  UIViewController+SlideView.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UIViewController+SlideView.h"

@implementation UIViewController (SlideView)

- (void)setTransAnimator:(TransitionAnimator *)transAnimator {
    objc_setAssociatedObject(self, @selector(transAnimator), transAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setInteractionController:(UIPercentDrivenInteractiveTransition *)interactionController {
    objc_setAssociatedObject(self, @selector(interactionController), interactionController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture {
    objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSlideVC:(UIViewController *)slideVC {
    objc_setAssociatedObject(self, @selector(slideVC), slideVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture {
    objc_setAssociatedObject(self, @selector(tapGesture), tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TransitionAnimator *)transAnimator {
    return objc_getAssociatedObject(self, @selector(transAnimator));
}

- (UIPercentDrivenInteractiveTransition *)interactionController {
    return objc_getAssociatedObject(self, @selector(interactionController));
}

- (UIPanGestureRecognizer *)panGesture {
    return objc_getAssociatedObject(self, @selector(panGesture));
}

- (UIViewController *)slideVC {
    return objc_getAssociatedObject(self, @selector(slideVC));
}

- (UITapGestureRecognizer *)tapGesture {
    return objc_getAssociatedObject(self, @selector(tapGesture));
}

#pragma mark - 展示侧滑栏
- (void)showSlideController:(UIViewController *)slideController {
    slideController.modalPresentationStyle = UIModalPresentationCustom;
    slideController.transitioningDelegate = self;
    slideController.view.frame = CGRectMake(70 * ratio, 0, kDeviceWidth - 70 * ratio, kDeviceHeight);
    
    if (!self.panGesture) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didCClickPanGestureRecognizer:)];
        [self setPanGesture:panGesture];
    }
    [slideController.view addGestureRecognizer:self.panGesture];
    
    if (!self.transAnimator) {
        [self setTransAnimator:[[TransitionAnimator alloc]init]];
    }
    
    if (!self.tapGesture) {
       UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLayerView)];
        [self setTapGesture:tapGesture];
    }
    
    if (!self.transAnimator.layerView) {
        UIView *layerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        layerV.backgroundColor = [UIColor blackColor];
        layerV.alpha = 0.0f;
        [self.transAnimator setLayerView:layerV];
    }
    [self.transAnimator.layerView addGestureRecognizer:self.tapGesture];
    
    
    [self setSlideVC:slideController];
    [self presentViewController:self.slideVC animated:YES completion:^{}];
}

#pragma mark - PresentModalDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transAnimator.animationType = AnimationTypePresent;
    return self.transAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transAnimator.animationType = AnimationTypeDismiss;
    return self.transAnimator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}

- (void)didCClickPanGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.view;
    if (recognizer.state  == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if ((location.x > 0) && self.navigationController.viewControllers.count == 1) {
            if (!self.interactionController) {
                UIPercentDrivenInteractiveTransition *perVC = [[UIPercentDrivenInteractiveTransition alloc]init];
                [self setInteractionController:perVC];
            }
            [self.slideVC dismissViewControllerAnimated:YES completion:^{}];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [recognizer translationInView:view];
        if (location.x > 0) {
            CGFloat distance = fabs(location.x / CGRectGetWidth(view.bounds));
            [self.interactionController updateInteractiveTransition:distance];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [recognizer translationInView:view];
        CGFloat distance = fabs(location.x / CGRectGetWidth(view.bounds));
        if (distance > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (void)clickLayerView {
    [self.slideVC dismissViewControllerAnimated:YES completion:nil];
}

@end
