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
    /** 结论:
     NSSet通过对象的hash方法返回的hash值以及isEqual方法返回的值 来判断两个对象是否重复
     hash 和 isEqual 有一个不匹配则两个对象非重复
     */
    NSSet *set = [NSSet setWithObjects:a, b, nil];
    NSLog(@"%@",set);
    
    NSLog(@"----------------------------------");
    
    NSDictionary *dict = @{a:@"a",b:@"b"};
    NSLog(@"%@",dict);
    //改变hash值
    a.hash_V = 100;

    ObjHashA *c = [ObjHashA new];
    c.hash_V = 1;
    NSLog(@"dict[a]: %@",dict[a]);
    NSLog(@"dict[c]: %@",dict[c]);
    /** 结论:
     NSDictionary的key必须实现NSCopying协议
     NSDictionary设置完key之后实际上key的值是你传的key的copy 所以直接用原来的key来取值可能取不到
     所以NSDictionary的key要注意 1.keycopy前后的hash不能变 2.对象的hash不要因为属性的改变而改变 3.用字符串 尽量避免使用自己的对象做key
     NSDictionary的key的相等判断同NSSet
     */
    
    NSLog(@"----------------------------------");
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        ObjHashA *o = [ObjHashA new];
        o.hash_V = i;
        [array addObject:o];
    }
    
    ObjHashA *t = [ObjHashA new];
    NSLog(@"%@",@([array containsObject:t]));
    
    /** 结论:
     数组根据isEqual来获取index 以及判断是否包含某个对象
     hash 和 isEqual 有一个不匹配则两个对象非重复
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
