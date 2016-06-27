//
//  TestObj.m
//  appearanceDemo
//
//  Created by xian on 6/27/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj

+ (void)load {
    TestObj *app = [TestObj appearance];
    app.count = 100;
    app.demoColor = [UIColor yellowColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 300, 300)];
    if (self) {
        
    }
    return self;
}

- (void)didMoveToSuperview {
    [self updateColor];
}

- (void)updateColor {
    TestObj *app = [TestObj appearance];
    self.backgroundColor = app.demoColor?:self.demoColor;
}

@end
