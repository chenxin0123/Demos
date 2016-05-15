//
//  CXTransitionContext.m
//  transition
//
//  Created by xian on 5/16/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXTransitionContext.h"
#import "CXSlideAnimationController.h"
#import "Define.h"
#import "CXInteractiveTransitionController.h"

@interface CXTransitionContext ()
@property (nonatomic, strong) CXTopTabBarController *privateContainerViewController;
@property (nonatomic, strong) UIView *privateContainerView;
@property (nonatomic, strong) UIViewController *privateFromViewController;
@property (nonatomic, strong) UIViewController *privateToViewController;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animationController;
@property (nonatomic, assign) BOOL isCancelled;
@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, assign) CGFloat transitionPercent;
@property (nonatomic, assign) CGFloat transitionDuration;

@property (nonatomic, assign) NSInteger fromIndex;
@property (nonatomic, assign) NSInteger toIndex;

@end

@implementation CXTransitionContext


#pragma mark - delegate
- (nullable UIView *)containerView {
    return self.privateContainerView;
}

- (BOOL)isAnimated {
    return (self.animationController!=nil);
}

- (BOOL)isInteractive {
    return self.interactive;
}

- (BOOL)transitionWasCancelled {
    return self.isCancelled;
}

- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationCustom;
}

 // It only makes sense to call these from an interaction controller that
 // conforms to the UIViewControllerInteractiveTransitioning protocol and was
 // vended to the system by a container view controller's delegate or, in the case
 // of a present or dismiss, the transitioningDelegate.
- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    if (self.animationController&&self.interactive) {
        self.transitionPercent = percentComplete;
        self.privateContainerView.layer.timeOffset = (CFTimeInterval)(percentComplete*self.transitionDuration);
        [self.privateContainerViewController graduallyChangeTabButtonAppearFromIndex:self.fromIndex toIndex:self.toIndex percentComplete:percentComplete];
    }
}
- (void)finishInteractiveTransition {
    self.interactive = NO;
    CGFloat pausedTime = self.privateContainerView.layer.timeOffset;
    self.privateContainerView.layer.speed = 1;
    self.privateContainerView.layer.timeOffset = 0;
    
    CGFloat timeSincePaused = [self.privateContainerView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.privateContainerView.layer.beginTime = timeSincePaused;
    
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(finishChangeButtonAppear:)];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    //转场结束 记得将beginTime设为0
    CGFloat remainTime = (1 - self.transitionPercent) * self.transitionDuration;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(remainTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.privateContainerView.layer.beginTime = 0.0;
    });
}

- (void)cancelInteractiveTransition {
    self.interactive = NO;
    self.isCancelled = true;
    
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(reverseCurrentAnimation:)];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [[NSNotificationCenter defaultCenter] postNotificationName:CXInteractionEndNotification object:self];
}

 // This must be called whenever a transition completes (or is cancelled.)
 // Typically this is called by the object conforming to the
 // UIViewControllerAnimatedTransitioning protocol that was vended by the transitioning
 // delegate.  For purely interactive transitions it should be called by the
 // interaction controller. This method effectively updates internal view
 // controller state at the end of the transition.
- (void)completeTransition:(BOOL)didComplete {
    if (didComplete) {
        [self.privateToViewController didMoveToParentViewController:self.privateContainerViewController];
        [self.privateFromViewController willMoveToParentViewController:nil];
        
        [self.privateFromViewController.view removeFromSuperview];
        [self.privateFromViewController removeFromParentViewController];
    } else {
        [self.privateToViewController didMoveToParentViewController:self.privateContainerViewController];
        [self.privateToViewController willMoveToParentViewController:nil];
        
        [self.privateToViewController.view removeFromSuperview];
        [self.privateToViewController removeFromParentViewController];
    }
    [self transitionEnd];
}
 

 // Currently only two keys are defined by the
 // system - UITransitionContextToViewControllerKey, and
 // UITransitionContextFromViewControllerKey.
 // Animators should not directly manipulate a view controller's views and should
 // use viewForKey: to get views instead.
- (nullable __kindof UIViewController *)viewControllerForKey:(NSString *)key {
    if ([UITransitionContextFromViewControllerKey isEqualToString:key]) {
        return self.privateFromViewController;
    } else if ([UITransitionContextToViewControllerKey isEqualToString:key]) {
        return self.privateToViewController;
    }
    return nil;
}

 // Currently only two keys are defined by the system -
 // UITransitionContextFromViewKey, and UITransitionContextToViewKey
 // viewForKey: may return nil which would indicate that the animator should not
 // manipulate the associated view controller's view.
- (nullable __kindof UIView *)viewForKey:(NSString *)key {
    if ([UITransitionContextFromViewKey isEqualToString:key]) {
        return self.privateFromViewController.view;
    } else if ([UITransitionContextToViewKey isEqualToString:key]) {
        return self.privateToViewController.view;
    }
    return nil;
}

- (CGAffineTransform)targetTransform {
    return CGAffineTransformIdentity;
}

 // The frame's are set to CGRectZero when they are not known or
 // otherwise undefined.  For example the finalFrame of the
 // fromViewController will be CGRectZero if and only if the fromView will be
 // removed from the window at the end of the transition. On the other
 // hand, if the finalFrame is not CGRectZero then it must be respected
 // at the end of the transition.
- (CGRect)initialFrameForViewController:(UIViewController *)vc {
    return CGRectZero;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc {
    return vc.view.frame;
}

#pragma mark - public 
+ (instancetype)transitionContextWithContainerController:(CXTopTabBarController *)controller
                                           containerView:(UIView *)containerView
                                      fromViewController:(UIViewController *)fromVC
                                        toViewController:(UIViewController *)toVC {
    CXTransitionContext *context = [self new];
    context.privateContainerViewController = controller;
    context.privateContainerView = containerView;
    context.privateFromViewController = fromVC;
    context.privateToViewController = toVC;
    
    context.fromIndex = [controller.viewControllers indexOfObject:fromVC];
    context.toIndex = [controller.viewControllers indexOfObject:toVC];
    
    context.privateToViewController.view.frame = context.privateContainerView.bounds;
    
    return context;
}

- (void)startInteractiveTranstionWithTransitionDelegate:(id<CXTabBarControllerTransitioningDelegate>)delegate {
    self.animationController = [delegate animationControllerForController:self.privateContainerViewController transitionFromViewController:self.privateFromViewController toViewController:self.privateToViewController];
    self.transitionDuration = [self.animationController transitionDuration:self];
    
    if (self.privateContainerViewController.interactive) {
      id<UIViewControllerInteractiveTransitioning> interactiveController = [delegate interactionControllerForController:self.privateContainerViewController animationController:self.animationController];
        NSAssert(interactiveController, @"Need for interaction controller for interactive transition.");
        [interactiveController startInteractiveTransition:self];
    } else {
        NSAssert(false, @"ContainerTransitionContext's Property 'interactive' must be true before starting interactive transiton");
    }
}

- (void)startNonInteractiveTranstionWithTransitionDelegate:(id<CXTabBarControllerTransitioningDelegate>)delegate {
    self.animationController = [delegate animationControllerForController:self.privateContainerViewController transitionFromViewController:self.privateFromViewController toViewController:self.privateToViewController];
    self.transitionDuration = [self.animationController transitionDuration:self];
    [self activateNonInteractiveTransition];
}

- (void)activateInteractiveTransition {
    self.interactive = YES;
    self.isCancelled = NO;
    [self.privateContainerViewController addChildViewController:self.privateToViewController];
    self.privateContainerView.layer.speed = 0;
    [self.animationController animateTransition:self];
}

#pragma mark - private
- (void)activateNonInteractiveTransition {
    self.interactive = NO;
    self.isCancelled = NO;
    [self.privateContainerViewController addChildViewController:self.privateToViewController];
    [self.animationController animateTransition:self];
}

- (void)finishChangeButtonAppear:(CADisplayLink *)displayLink {
    CGFloat percentFrame = 1/(self.transitionDuration * 60.0);
    self.transitionPercent += percentFrame;
    
    if (self.transitionPercent < 1.0) {
        [self.privateContainerViewController graduallyChangeTabButtonAppearFromIndex:self.fromIndex toIndex:self.toIndex percentComplete:self.transitionPercent];
    } else {
        [displayLink invalidate];
        [self.privateContainerViewController graduallyChangeTabButtonAppearFromIndex:self.fromIndex toIndex:self.toIndex percentComplete:1];
    }
}

- (void)reverseCurrentAnimation:(CADisplayLink *)displayLink {
    CGFloat timeOffset = self.privateContainerView.layer.timeOffset - displayLink.duration;
    if (timeOffset > 0) {
        self.privateContainerView.layer.timeOffset = timeOffset;
        self.transitionPercent = timeOffset / self.transitionDuration;
        [self.privateContainerViewController graduallyChangeTabButtonAppearFromIndex:self.fromIndex toIndex:self.toIndex percentComplete:self.transitionPercent];
    } else {
        [displayLink invalidate];
        self.privateContainerView.layer.timeOffset = 0;
        self.privateContainerView.layer.speed = 1;
        [self.privateContainerViewController graduallyChangeTabButtonAppearFromIndex:self.fromIndex toIndex:self.toIndex percentComplete:1];
        
        //修复闪屏Bug: speed 恢复为1后，动画会立即跳转到它的最终状态，而 fromView 的最终状态是移动到了屏幕之外，因此在这里添加一个假的掩人耳目。
        //为何不等 completion block 中恢复 fromView 的状态后再恢复 containerView.layer.speed，事实上那样做无效，原因未知。
        UIView *view = [self.privateContainerViewController.view snapshotViewAfterScreenUpdates:NO];
        [self.privateContainerView addSubview:view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/60.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
        });
        
    }
}

/**
 *  结束非交互转场 最后
 */
- (void)transitionEnd {
    
    if ([self.animationController respondsToSelector:@selector(animationEnded:)]) {
        [self.animationController animationEnded:!self.isCancelled];
    }
    if (self.isCancelled) {
        [self.privateContainerViewController restoreSelectedIndex];
        self.isCancelled = NO;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:CXContainerTransitionEndNotification object:self];
}
@end
