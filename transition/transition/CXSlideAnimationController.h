//
//  CXSlideAnimationController.h
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"
@interface CXSlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)animationControllerWithTransitionType:(CXTransitionType)transitionType;

@end
