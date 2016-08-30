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
 2.hidden|disabled user interactions|alpha<=0.01 该视图的hitTest:withEvent:返回nil 即使pointInside:withEvent:返回YES
 3.hitTest:withEvent:内部调用子视图的pointInside:withEvent:如果返回YES则递归调用子视图的hitTest:withEvent:
 4.hitTest:withEvent:会忽略满足2的子视图
 4.hitTest:withEvent:返回非nil的View 该UIView成为第一响应者 无论该View是否符合2 无论是否有父父视图
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
    self.contentView.alpha = 0.01;
    self.contentView.userInteractionEnabled = NO;
    self.contentView.hidden = YES;
    
    TUIButton *btn = [TUIButton button];
//    btn.hidden = YES;
    gbtn = btn;
    
    TUIImageView *imgv = [[TUIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    imgv.frame = CGRectMake(0, 220, 320, 200);
    imgv.backgroundColor = [UIColor blackColor];
//    imgv.alpha = 0.011;
//    imgv.hidden = YES;
    imgv.userInteractionEnabled = YES;
    gimg = imgv;
    
    [self.contentView addSubview:btn];
    [self.contentView addSubview:imgv];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
//}
@end
