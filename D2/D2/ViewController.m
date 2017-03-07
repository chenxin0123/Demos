//
//  ViewController.m
//  D2
//
//  Created by CX on 8/18/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "PaopapView.h"


/**
 结论：extendedLayoutIncludesOpaqueBars|automaticallyAdjustsScrollViewInsets
 1.automaticallyAdjustsScrollViewInsets默认YES 当控制器的view是个UIScrollView或其子类且navigationBar.translucent为YES时有效 当extendedLayoutIncludesOpaqueBars为YES且View的子View为仅含一个scrollview时有效
 2.当navigationBar.translucent为YES时 控制器的view默认从屏幕的(0,0)开始 当navigationBar.translucent为NO时 从屏幕(0,64)开始
 3.在touchesBegan中执行self.navigationController.navigationBar.translucent = YES; 子视图位置立即往上移动64距离
 4.extendedLayoutIncludesOpaqueBars默认NO 表示View的布局范围是否包含不透明的bars 仅bar不透明时有效 就导航栏而言 设为YES时View的布局范围包含导航栏 i.eView从(0,0)开始 最后 当控制器的View是个UIScrollView时 该属性无效
 5.automaticallyAdjustsScrollViewInsets在statusBar不隐藏的时候也有效 此时便宜20
 */

/**
 结论：drawrect
 1.当View实现了drawrect 背景色无效 子视图有效
 2.改变size不会触发drawrect 但是当contentMode = UIViewContentModeRedraw;时改变size会触发drawrect
 */


@interface ViewController ()
@end

@implementation ViewController


- (void)loadView {
    UIScrollView *sv = [UIScrollView new];
    sv.exclusiveTouch = NO;
    sv.contentSize = CGSizeMake(1500, 1500);
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [sv addGestureRecognizer:ges];
    
    self.view = sv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    /****************************** extendedLayoutIncludesOpaqueBars|automaticallyAdjustsScrollViewInsets ******************************/
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.navigationController.navigationBar.translucent = NO;
//        self.view.backgroundColor = [UIColor redColor];
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//    v.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:v];

    
}

- (void)tap:(UITapGestureRecognizer *)ges {
    
    CGPoint p = [ges locationInView:self.view];
//    p.x -= ((UIScrollView *)self.view).contentOffset.x;
//    p.y -= ((UIScrollView *)self.view).contentOffset.y;
    
    PaopapView *paopao = [PaopapView new];
    
    CGFloat w,h;
    w = arc4random()%100 + 50;
    h = arc4random()%100 + 50;
    paopao.layer.position = p;
    
    paopao.frame = CGRectMake(p.x-w/2, p.y-h, w, h);
    [self.view addSubview:paopao];
    
    paopao.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        paopao.transform = CGAffineTransformIdentity;
    }];
}

@end
