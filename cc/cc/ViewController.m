//
//  ViewController.m
//  cc
//
//  Created by CX on 4/23/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"

UIButton *gbtn;


@interface TUIButton : UIButton

@end

@implementation TUIButton
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//    [super touchesBegan:touches withEvent:event];
////    [self.nextResponder touchesBegan:touches withEvent:event];
//    
//}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    id v = [super hitTest:point withEvent:event];
//
//    return self;
//}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

@end


@interface TUIImageView : UIImageView

@end
@implementation TUIImageView
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
    
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}
//
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    id v = [super hitTest:point withEvent:event];
//    if (!v) {
//        return self;
//    }
//    if (v == self) {
//        return gbtn;
//    }
    return gbtn;
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scro = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scro];
    scro.pagingEnabled = YES;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    scro.contentSize = CGSizeMake(scro.frame.size.width*5, scro.frame.size.height);
    for (int i=0; i<5; i++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i*w, 0, w, h)];
        [scro addSubview:v];
        v.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1];
    }
    
    TUIButton *btn = [TUIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"touch me" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, h/2.0+100, w,100);
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:btn];
    gbtn = btn;
    
    TUIImageView *imgv = [[TUIImageView alloc] initWithImage:nil];
    imgv.frame = CGRectMake(0, h/2.0, w, h/2);
    imgv.backgroundColor = [UIColor blackColor];
    imgv.alpha = 0.8;
//    imgv.hidden = YES;
    imgv.userInteractionEnabled = YES;
    [self.view addSubview:imgv];
}

- (void)btnTouch:(id)sender {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
@end
