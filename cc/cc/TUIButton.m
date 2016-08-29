//
//  TUIButton.m
//  cc
//
//  Created by CX on 8/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "TUIButton.h"

@implementation TUIButton

+ (instancetype)button {
    TUIButton *btn = [TUIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"touch me" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100,100);
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    return btn;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//    return self;//[super hitTest:point withEvent:event];
//}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return [super pointInside:point withEvent:event];
}
//- (BOOL)pointMostlyInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return YES;
//}

@end
