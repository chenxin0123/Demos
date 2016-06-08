//
//  ViewController.m
//  runtime_demo
//
//  Created by CX on 5/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "ObjcA.h"
#include "StaticTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    ObjcA *a = ObjcA.new;
//    [a performSelector:@selector(objcA)];
    
    //静态函数通过指针可以访问到
    static_test_public();
//    static_test_private();
    p();
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
