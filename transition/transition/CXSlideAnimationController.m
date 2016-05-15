//
//  CXSlideAnimationController.m
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXSlideAnimationController.h"

@interface CXSlideAnimationController ()

@property(nonatomic, assign) CXTransitionType transitionType;

@end

@implementation CXSlideAnimationController

#pragma mark - public
+ (instancetype)animationControllerWithTransitionType:(CXTransitionType)transitionType {
    CXSlideAnimationController *animationController = [CXSlideAnimationController new];
    animationController.transitionType = transitionType;
    return animationController;
}

#pragma mark - delegate
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGFloat translation = containerView.frame.size.width;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    
    switch (self.transitionType) {
        case CXNavigationControllerOperationPush: {
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            [containerView addSubview:toView];
            break;
        }
        case CXNavigationControllerOperationPop: {
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            [containerView addSubview:toView];
            break;
        }
        case CXTabOperationDirectionLeft: {
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            [containerView addSubview:toView];
            break;
        }
        case CXTabOperationDirectionRight: {
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            [containerView addSubview:toView];
            break;
        }
        case CXModalOperationPresentaion: {
            translation =  containerView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation(0, translation);
            fromViewTransform = CGAffineTransformIdentity;
            [containerView addSubview:toView];
            break;
        }
        case CXModalOperationDismissal: {
            translation =  containerView.frame.size.height;
            toViewTransform = CGAffineTransformIdentity;
            fromViewTransform = CGAffineTransformMakeTranslation(0, translation);
            break;
        }
    }
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
