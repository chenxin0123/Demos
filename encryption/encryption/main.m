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
    NSString *origin = @"chenxinchenxinchenxinchenxinchenxin";
    
    NSString *res = [EncryptManager doEncrypt:origin];
    //816c5b0c5e258fd2dec67c60b6bfb1ddc6bc9fa8a99005567f71f2c1678ced3b18194a4e97938f7a
    //7c22b32ebeed0c1101f502a7deda07f934816d2e1895bbd4d14022f7fe292669e8c2692bd974e8a7
    //88d8d943fdd0b37a5fcfdc0d3fd0bec61cb88cb4bcc910a04f0600a22e624d0270a2b00c13169cf6
    //8ede545aa19dc198af7e7f6a2fe023b3fbbfe574f930055c16c9faeae1b33b2b0073fe8688834d4f
    NSString *dec = [EncryptManager doDecEncrypt:res];
    NSLog(@"\n\n\n明文：%@\n密文：%@\r\n解密：%@",origin,res,dec);
}

int main(int argc, char * argv[]) {
    des3_test();
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    
    
}



