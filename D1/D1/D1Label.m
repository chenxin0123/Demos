//
//  D1Label.m
//  D1
//
//  Created by CX on 7/6/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "D1Label.h"

@implementation D1Label

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (CGSize)sizeThatFits:(CGSize)size {
    CGSize ret = [super sizeThatFits:size];
    return ret;
}

///autolayout的content-hugging和compression-resistance依赖这个方法返回的内容
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width = size.width/2;
    return size;
}


@end
