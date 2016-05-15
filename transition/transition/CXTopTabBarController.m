//
//  CXTopTabBarController.m
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXTopTabBarController.h"
#import "CXTransitionContext.h"
#import "Define.h"
#import "CXTabBarControllerTransitioningDelegate.h"
#import "CXInteractiveTransitionController.h"

@interface CXTopTabBarController ()
@property (nonatomic, strong) UIView *privateContainer;
@property (nonatomic, strong) UIView *tabBarContainer;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) NSMutableArray *tabItemTitles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, assign) NSInteger priorSelectedIndex;
@property (nonatomic, assign) BOOL shouldReserve;

@property (nonatomic, strong) CXTransitionContext *transitionContext;

@end

@implementation CXTopTabBarController
#pragma mark - class method
+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers {
    NSAssert(viewControllers.count>0, @"can't init with 0 child VC");
    CXTopTabBarController *vc = [self new];
    vc.viewControllers = viewControllers;
    return vc;
}

#pragma mark - lifeCycle
- (void)loadView {
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.privateContainer = [UIView new];
    [self.view addSubview:self.privateContainer];
    self.privateContainer.backgroundColor = [UIColor blackColor];
    self.privateContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    self.tabBarContainer = [UIView new];
    [self.view addSubview:self.tabBarContainer];
    self.tabBarContainer.backgroundColor = [UIColor blackColor];
    self.tabBarContainer.tintColor = [UIColor yellowColor];
    NSInteger count = self.viewControllers.count;
    self.tabBarContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tabBarContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:count*64]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tabBarContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:44]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tabBarContainer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.privateContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tabBarContainer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.privateContainer attribute:NSLayoutAttributeCenterY multiplier:0.2 constant:0]];
    
    for (int i=0; i<self.viewControllers.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tabBarContainer addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:self.tabItemTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(barButtonItemTouched:) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:64]];
        [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:44]];
        [self.tabBarContainer addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tabBarContainer attribute:NSLayoutAttributeLeft multiplier:1 constant:(i+0.5)*64]];
        [self.tabBarContainer addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.tabBarContainer attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
    }
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    [self setup];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.viewControllers.count && self.selectedIndex==NSNotFound) {
        self.selectedIndex = 0;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - init
- (void)setup {
    _selectedIndex = NSNotFound;
    _tabItemTitles = [NSMutableArray array];
    //非交互转场结束
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transitonEndAction) name:CXContainerTransitionEndNotification object:nil];
}

#pragma mark - setter/getter

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (self.shouldReserve) {
        self.shouldReserve = NO;
    } else {
        [self transitionViewControllerFromIndex:_selectedIndex toIndex:selectedIndex];
    }
    
    _selectedIndex = selectedIndex;
}

- (UIViewController *)selectedViewController {
    if (self.viewControllers && self.viewControllers.count > self.selectedIndex) {
        return self.viewControllers[self.selectedIndex];
    }
    return nil;
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    NSInteger index = [self.viewControllers indexOfObject:selectedViewController];
    if (index != NSNotFound) {
        self.selectedIndex = index;
    }
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    
    [self.tabItemTitles removeAllObjects];
    for (UIViewController *vc in viewControllers) {
        NSString *title = vc.title?:@"lazy";
        [self.tabItemTitles addObject:title];
        vc.view.translatesAutoresizingMaskIntoConstraints = YES;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
}
#pragma mark - event
- (void)barButtonItemTouched:(UIButton *)sender {
    NSInteger index = [self.tabBarContainer.subviews indexOfObject:sender];
    if (index!=NSNotFound && index!=self.selectedIndex) {
        self.selectedIndex = index;
    }
}
#pragma mark - notification
- (void)transitonEndAction {
    self.transitionContext = nil;
    self.tabBarContainer.userInteractionEnabled = YES;
}
#pragma mark - private 
/**
 *  非交互转场
 */
- (void)transitionViewControllerFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (!(self.viewControllers.count && fromIndex!=toIndex && fromIndex>=0 && toIndex>=0 && toIndex<self.viewControllers.count)) {
        return;
    }
    
    //called when init
    if (fromIndex == NSNotFound) {
        UIViewController *vc = self.viewControllers[toIndex];
        [self addChildViewController:vc];
        [self.privateContainer addSubview:vc.view];
        [vc willMoveToParentViewController:self];
        [vc didMoveToParentViewController:self];
        [self changeTabButtonAppearAtIndex:toIndex];
        return;
    }
    if (self.cx_transitionDelegate) {
        self.tabBarContainer.userInteractionEnabled = NO;
        UIViewController *fromVC = self.viewControllers[fromIndex];
        UIViewController *toVC = self.viewControllers[toIndex];
        self.transitionContext = [CXTransitionContext transitionContextWithContainerController:self containerView:self.privateContainer fromViewController:fromVC toViewController:toVC];
        if (self.interactive) {
            self.priorSelectedIndex = self.selectedIndex;
            [self.transitionContext startInteractiveTranstionWithTransitionDelegate:self.cx_transitionDelegate];
        } else {
            [self.transitionContext startNonInteractiveTranstionWithTransitionDelegate:self.cx_transitionDelegate];
            [self changeTabButtonAppearAtIndex:toIndex];
        }
    } else {
        //Transition Without Animation
        UIViewController *priorSelectedVC = self.viewControllers[fromIndex];
        [priorSelectedVC willMoveToParentViewController:nil];
        [priorSelectedVC.view removeFromSuperview];
        [priorSelectedVC removeFromParentViewController];
        
        UIViewController *curSelectedVC = self.viewControllers[toIndex];
        [self addChildViewController:curSelectedVC];
        [self.privateContainer addSubview:curSelectedVC.view];
        [curSelectedVC didMoveToParentViewController:self];
        
        [self changeTabButtonAppearAtIndex:toIndex];
    }
    
}
- (void)changeTabButtonAppearAtIndex:(NSInteger)index {
    
    NSArray *btnList = self.tabBarContainer.subviews;
    for (NSInteger i=0; i<btnList.count; i++) {
        UIButton *btn = (UIButton *)btnList[i];
        if (i == index) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - public 
- (void)graduallyChangeTabButtonAppearFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex percentComplete:(CGFloat)percentComplete {
    UIButton *fromBtn = self.tabBarContainer.subviews[fromIndex];
    UIButton *toBtn = self.tabBarContainer.subviews[toIndex];
    [fromBtn setTitleColor:[UIColor colorWithRed:1 green:percentComplete blue:percentComplete alpha:1] forState:UIControlStateNormal];
    [toBtn setTitleColor:[UIColor colorWithRed:1 green:1-percentComplete blue:1-percentComplete alpha:1] forState:UIControlStateNormal];
}
- (void)restoreSelectedIndex {
    self.shouldReserve = YES;
    self.selectedIndex = self.priorSelectedIndex;
}
#pragma mark - GestureRecognizer

- (void)handlePan:(UIPanGestureRecognizer *)gestures {
    if (self.viewControllers.count<2 && !self.cx_transitionDelegate) {
        return;
    }
    
    CGFloat tx = [gestures translationInView:self.view].x;
    tx = fabs(tx);
    
    CGFloat progress = tx / self.view.frame.size.width;
    switch (gestures.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            CGFloat vx = [gestures velocityInView:self.view].x;
            if (vx < 0) {
                if (self.selectedIndex < (self.viewControllers.count-1)) {
                    self.selectedIndex += 1;
                }
            } else if (self.selectedIndex > 0) {
                self.selectedIndex -= 1;
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.cx_transitionDelegate.interactionController updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interactive = NO;
            if (progress > 0.4) {
                [self.cx_transitionDelegate.interactionController finishInteractiveTransition];
            } else {
                [self.cx_transitionDelegate.interactionController cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
