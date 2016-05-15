//
//  InteractiveTransition.h
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class CXTransitionContext;
/**
 *  交互控制器
 */
@interface CXInteractiveTransitionController : NSObject<UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) CXTransitionContext *transitionContext;

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;
@end
