//
//  ViewController.m
//  D2
//
//  Created by CX on 8/18/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"


/**
 结论：
 1.automaticallyAdjustsScrollViewInsets默认YES 且当且仅当控制器的view是个UIScrollView或其子类且navigationBar.translucent为YES时才有效
 2.当navigationBar.translucent为YES时 控制器的view默认从屏幕的(0,0)开始 当navigationBar.translucent为NO时 从屏幕(0,64)开始
 3.在touchesBegan中执行self.navigationController.navigationBar.translucent = YES; 子视图位置立即往上移动64距离
 4.extendedLayoutIncludesOpaqueBars默认NO 表示View的布局范围是否包含不透明的bars 仅bar不透明时有效 就导航栏而言 设为YES时View的布局范围包含导航栏 i.eView从(0,0)开始 最后 当控制器的View是个UIScrollView时 该属性无效
 */

@interface ViewController ()

@end

@implementation ViewController


- (void)loadView {
    self.view = [UIScrollView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.translucent = NO;
        self.view.backgroundColor = [UIColor redColor];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.extendedLayoutIncludesOpaqueBars = YES;
}

@end
