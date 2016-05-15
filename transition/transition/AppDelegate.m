//
//  AppDelegate.m
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "AppDelegate.h"
#import "CXTopTabBarController.h"
#import "CXTabBarControllerTransitioningDelegate.h"
#import "CXInteractiveTransitionController.h"
#import "Define.h"
#import "CXSlideAnimationController.h"
@interface AppDelegate () <CXTabBarControllerTransitioningDelegate>
@end

@implementation AppDelegate
@synthesize interactionController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self configureRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - init
- (UIViewController *)configureRootViewController {
    
    UIViewController *subVC1 = [UIViewController new];
    subVC1.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.8 blue:1 alpha:1];
    subVC1.title = @"first";
    
    UIViewController *subVC2 = [UIViewController new];
    subVC2.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1];
    subVC2.title = @"second";
    
    UIViewController *subVC3 = [UIViewController new];
    subVC3.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.4 alpha:1];
    subVC3.title = @"third";
    
    UIViewController *subVC4 = [UIViewController new];
    subVC4.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.4 blue:0.5 alpha:1];
    subVC4.title = @"fourth";
    
    CXTopTabBarController *container = [CXTopTabBarController tabBarControllerWithViewControllers:@[subVC1,subVC2,subVC3,subVC4]];
    container.cx_transitionDelegate = self;
    
    return container;
}


#pragma mark - CXTabBarControllerTransitioningDelegate 转场代理

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForController:(CXTopTabBarController *)controller transitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSInteger fromIndex = [controller.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [controller.viewControllers indexOfObject:toVC];
    CXTransitionType transitionType = fromIndex<toIndex?CXTabOperationDirectionRight:CXTabOperationDirectionLeft;
    CXSlideAnimationController *animationController = [CXSlideAnimationController animationControllerWithTransitionType:transitionType];
    return animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForController:(CXTopTabBarController *)controller animationController:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (!self.interactionController) {
        self.interactionController = [CXInteractiveTransitionController new];
    }
    return self.interactionController;
}


@end
