//
//  CXKVOObject.m
//  KVO_demo
//
//  Created by CX on 6/12/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXKVOObject.h"

@implementation CXKVOObject

//关闭自动kvo automaticallyNotifiesObserversForKey
+ (BOOL)automaticallyNotifiesObserversOfAge {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfBoy {
    return YES;
}
- (void)setAge:(NSInteger)age {
    [self willChangeValueForKey:@"age"];
    _age = age;
    [self didChangeValueForKey:@"age"];
}

- (void)setBoy:(BOOL)boy {
    [self willChangeValueForKey:@"isBoy"];
    _boy = boy;
    [self didChangeValueForKey:@"isBoy"];
}

@end
