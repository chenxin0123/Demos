//
//  CXTopTabBarController.h
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXTabBarControllerTransitioningDelegate;

@interface CXTopTabBarController : UIViewController

@property (nonatomic, strong, readonly) NSArray *viewControllers;

@property (nonatomic, weak) id<CXTabBarControllerTransitioningDelegate> cx_transitionDelegate;

@property (nonatomic, assign) BOOL interactive;

+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers;

- (void)graduallyChangeTabButtonAppearFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex percentComplete:(CGFloat)percentComplete;


- (void)restoreSelectedIndex;

@end
