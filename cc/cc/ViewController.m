//
//  ViewController.m
//  cc
//
//  Created by CX on 4/23/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "TUIView.h"
#import "TUIButton.h"
#import "TUIImageView.h"


/**
 结论：
 1.子视图测试顺序与addSubView顺序相反
 2.hitTest:withEvent:内部调用子视图的pointInside:withEvent:
 3.hidden|disabled user interactions|alpha<=0.01 hitTest:withEvent:返回nil 否则如果没有子视图则返回self
 4.hitTest:withEvent:返回非nil的View 处理结束 
 5.如果hitTest:withEvent:返回的View是个UIButton 其frame跟touch point距离太大 该Button仍然不处理该事件 经测试最大范围为上下左右70%宽高 
   所以如果要让一个View始终处理某个事件 重写该Button的pointInside:withEvent:比较靠谱 即使是该Button的hitTest:withEvent:中返回self也有此范围限制 
   原因是UIButton重写了pointMostlyInside:withEvent:
 */

UIButton *gbtn;
UIImageView *gimg;
@interface ViewController ()
@property (nonatomic, strong) TUIView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.contentView = [TUIView new];
    [self.view addSubview:self.contentView];
    self.contentView.frame = self.view.bounds;
//    self.contentView.alpha = 0.01;
//    self.contentView.userInteractionEnabled = NO;
//    self.contentView.hidden = YES;
    
    TUIButton *btn = [TUIButton button];
    [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    gbtn = btn;
    
    TUIImageView *imgv = [[TUIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    imgv.frame = CGRectMake(0, 220, 320, 200);
    imgv.backgroundColor = [UIColor blackColor];
//    imgv.alpha = 0.011;
//    imgv.hidden = YES;
    imgv.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTouch:)];
    [imgv addGestureRecognizer:ges];
    gimg = imgv;
    [self.contentView addSubview:btn];
    [self.contentView addSubview:imgv];
}

- (void)btnTouch:(id)sender {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)imageViewTouch:(id)sender {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
@end
