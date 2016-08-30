//
//  TUIView.m
//  cc
//
//  Created by CX on 8/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "TUIView.h"
#import "ViewController.h"

@implementation TUIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    UIView *v = [super hitTest:point withEvent:event];
    return v;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//    return [super pointInside:point withEvent:event];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
}



@end
