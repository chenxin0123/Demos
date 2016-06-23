//
//  main.m
//  encryption
//
//  Created by xian on 6/22/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "NSString+encryption.h"
#import "EncryptManager.h"

void base64Test_str() {
    NSString *origin = @"Hello!!";
    NSString *base64 = [origin base64EncodedString];
    NSLog(@"%@:%@",[base64 base64DecodedString],base64);
}

void base64Test_dic() {
    NSDictionary *dic = @{@"id":@"124"};
    NSLog(@"%@",dic);
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *str = [data base64EncodedStringWithOptions:0];
    NSData *data2 = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSLog(@"%@|||%@|||%@|||%@",str,[NSJSONSerialization JSONObjectWithData:data2 options:0 error:nil],[str base64DecodedString],[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

void des3_test() {
//    id origin = @"chenxinchenxinchenxinchenxinchenxin";
//    id origin = @{@"name":@"cx",@"gender":@(1)};
    id origin = @[@"ddd",@"eee",@"aaa",@(33)];
    
    NSString *res = [EncryptManager tripleDESEncrypt:origin];
    NSString *dec = [EncryptManager tripleDESDecrypt:res];
    NSLog(@"\n\n\n明文[%@]：%@\n密文：%@\r\n解密[%@]：%@",[origin class],origin,res,[dec class],dec);
}

int main(int argc, char * argv[]) {
    des3_test();
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    
    
}



