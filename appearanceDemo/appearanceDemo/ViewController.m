//
//  ViewController.m
//  appearanceDemo
//
//  Created by xian on 6/27/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "TestObj.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestObj *obj = [TestObj new];
    obj.demoColor = [UIColor redColor];
    obj.count = 88;
    
    TestObj *app = [TestObj appearance];
    
    [self.view addSubview:obj];
    
    NSLog(@"sin = %@, app = %@",@(obj.count),@(app.count));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
