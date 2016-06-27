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
    
    [self.view addSubview:obj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
