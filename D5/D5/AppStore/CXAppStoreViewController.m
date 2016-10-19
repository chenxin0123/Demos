//
//  CXAppStoreViewController.m
//  D5
//
//  Created by xian on 26/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXAppStoreViewController.h"

@interface CXAppStoreViewController ()

@end

@implementation CXAppStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = self.view.center;
    button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped {
    //https://itunes.apple.com/search?parameterkeyvalue
    
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software",[@"偶遇公交" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //https://itunes.apple.com/search?term=偶遇公交&country=CN&media=software
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
