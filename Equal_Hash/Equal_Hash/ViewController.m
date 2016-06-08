//
//  ViewController.m
//  Equal_Hash
//
//  Created by CX on 5/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "ObjHashA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ObjHashA *a = [ObjHashA new];
    a.hash_V = 1;
    
    ObjHashA *b = [ObjHashA new];
    b.hash_V = 2;
    
    if ([a isEqual:b]) {
        NSLog(@"equal");
    }else {
        NSLog(@"not equal");
    }
    
    NSSet *set = [NSSet setWithObjects:a, b, nil];
    NSLog(@"set:%@",set);
    
    NSDictionary *dict = @{a:@"a",b:@"b"};
    NSLog(@"dict:%@",dict);
    
    //改变hash值
    a.hash_V = 100;
    ObjHashA *c = [ObjHashA new];
    c.hash_V = 1;
    NSLog(@"dict[a]: %@",dict[a]);
    NSLog(@"dict[c]: %@",dict[c]);
    
    
    a.hash_V=1;b.hash_V=2;c.hash_V=3;
    NSArray *array = @[a,b,c];
    NSLog(@"array:%@",array);
    
    a.hash_V = 100;
    ObjHashA *d = a.copy;
    d.hash_V = 100;
    NSLog(@"a.index = %@",@([array indexOfObject:a]));
    NSLog(@"d.index = %@",@([array indexOfObject:d]));
    
    
    
    NSMutableArray *marr = [NSMutableArray array];
    for (int i=0; i<10000000; i++) {
        [marr addObjectsFromArray:array];
    }
    NSLog(@"d.index in NSMutableArray = %@",@([array indexOfObject:d]));
    /** 结论:
     NSSet通过对象的hash方法返回的hash值以及isEqual方法返回的值 来判断两个对象是否重复 即使两个对象的地址不一样 只要hash和isEqual返回正确也是重复对象
     hash 和 isEqual 有一个不匹配则两个对象非重复
     
     NSDictionary的key必须实现NSCopying协议
     NSDictionary设置完key之后实际上key的值是你传的key的copy 所以直接用原来的key来取值可能取不到
     所以NSDictionary的key要注意 1.keycopy前后的hash不能变 2.对象的hash不要因为属性的改变而改变 3.用字符串 尽量避免使用自己的对象做key
     NSDictionary的key的相等判断同NSSet
     
     NSArray取对象的索引时 如果指针相等就算相等 否则调用对象的isEqual方法(并没有调用hash方法)
     */
}

/**
 *  Used to create object hashes
 *  Based on http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
 */
#define MAS_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define MAS_NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (MAS_NSUINT_BIT - howmuch)))


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
