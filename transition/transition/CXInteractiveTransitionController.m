//
//  InteractiveTransition.m
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXInteractiveTransitionController.h"
#import "CXTransitionContext.h"

@implementation CXInteractiveTransitionController

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [self.transitionContext activateInteractiveTransition];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [self.transitionContext updateInteractiveTransition:percentComplete];
}

- (void)cancelInteractiveTransition {
    [self.transitionContext cancelInteractiveTransition];
}

- (void)finishInteractiveTransition {
    [self.transitionContext finishInteractiveTransition];
}

@end
