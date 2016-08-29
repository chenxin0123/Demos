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
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTouch:)];
        [self addGestureRecognizer:ges];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    NSLog(@"%@",NSStringFromCGPoint(point));
    UIView *v = [super hitTest:point withEvent:event];
    return gbtn;
}
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//    return [super pointInside:point withEvent:event];
//}

- (void)viewTouch:(id)sender {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}


@end
