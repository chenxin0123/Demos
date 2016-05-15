//
//  CXTabBarControllerTransitioningDelegate.h
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXInteractiveTransitionController;
@class CXTopTabBarController;
/**
 *  转场代理
 */
@protocol CXTabBarControllerTransitioningDelegate <NSObject>

@property(nonatomic, strong, readwrite) CXInteractiveTransitionController *interactionController;

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForController:(CXTopTabBarController *)controller transitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForController:(CXTopTabBarController *)controller animationController:(id<UIViewControllerAnimatedTransitioning>)animator;

@end

