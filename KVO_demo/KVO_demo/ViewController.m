//
//  ViewController.m
//  KVO_demo
//
//  Created by CX on 6/12/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "CXKVOObject.h"
#import <objc/runtime.h>

static NSArray *ClassMethodNames(Class c) {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++)
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    free(methodList);
    
    NSLog(@"%@:%@",NSStringFromClass(c),array);
    
    return array;
}

@interface ViewController ()
@property (nonatomic,strong) id value;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
    
}

static void *CXKVOContext = &CXKVOContext;

- (void)test1 {
    CXKVOObject *obj = [CXKVOObject new];
    self.value = obj;
    
    ClassMethodNames([obj class]);
    ClassMethodNames(object_getClass(obj));
    [obj addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:CXKVOContext];
    [obj addObserver:self forKeyPath:@"_age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:CXKVOContext];
    [obj addObserver:self forKeyPath:@"isBoy" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:CXKVOContext];
    [obj addObserver:self forKeyPath:@"boy" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:CXKVOContext];
    obj.age = 10;
    //_age不会触发 age会触发
    [obj setValue:@(11) forKey:@"_age"];
    //old:11 new:12说明上面那句确实改变了age的值
    obj.age = 12;
    
    obj.boy = YES;
    
    ClassMethodNames([obj class]);
    ClassMethodNames(object_getClass(obj));
    
    
    
    /**
     setValue:forKey 方法有效 但当key使用_key形式时 无法触发KVO
     重写setter方法之后 只能手动KVO
     手动KVO可以自定义key
     KVO以属性名为key 与ivar名无关
     */
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == CXKVOContext) {
        NSLog(@"%@:keyPath [old:%@ new:%@]",keyPath,change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
