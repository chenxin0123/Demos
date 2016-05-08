//
//  ObjcA.m
//  runtime_demo
//
//  Created by CX on 5/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ObjcA.h"

#import <objc/runtime.h>

@interface ObjcB:NSObject
- (void)objcB;
@end
@implementation ObjcB

- (void)objcB {
    NSLog(@"objcB");
}
@end



@implementation ObjcA
- (void)objcA {
    NSLog(@"objcA");
}

+ (void)load {
    Method mb = class_getInstanceMethod([ObjcB class], @selector(objcB));
    IMP imp = method_getImplementation(mb);
    //改变实现 原实现被覆盖
    class_replaceMethod([self class], @selector(objcA), imp, method_getTypeEncoding(mb));
}

@end