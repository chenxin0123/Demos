//
//  CXTransitionContext.h
//  transition
//
//  Created by xian on 5/16/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CXTopTabBarController.h"
#import "CXTabBarControllerTransitioningDelegate.h"
@interface CXTransitionContext : NSObject<UIViewControllerContextTransitioning>

+ (instancetype)transitionContextWithContainerController:(CXTopTabBarController *)controller
                                           containerView:(UIView *)containerView
                                      fromViewController:(UIViewController *)fromVC
                                        toViewController:(UIViewController *)toVC;

- (void)startInteractiveTranstionWithTransitionDelegate:(id<CXTabBarControllerTransitioningDelegate>)delegate;
- (void)startNonInteractiveTranstionWithTransitionDelegate:(id<CXTabBarControllerTransitioningDelegate>)delegate;

- (void)activateInteractiveTransition;
- (void)activateNonInteractiveTransition;
@end
