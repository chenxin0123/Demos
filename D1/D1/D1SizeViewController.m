//
//  D1SizeViewController.m
//  D1
//
//  Created by CX on 9/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "D1SizeViewController.h"
#import "D1Label.h"

@implementation D1SizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    D1Label *label = [[D1Label alloc] init];
    
    label.text = @"text";
    label.frame = CGRectMake(50, 100, 100, 50);
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:label];
}

@end
