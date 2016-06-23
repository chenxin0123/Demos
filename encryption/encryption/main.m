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

#define RSA_PUBLIC_KEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDA2TbEb1FRs8UfNiLvhMDfqLA5IBhT8qCPCIrOcRk3E1SrDB7hO1pwnJ2cZmbdYKCllTYtJHmoDKNN3v6GEuuo6dZ8kD3bPW7fDArqh32Fglrn7ZHmvYdCO6M1dTpgMLxjRYXKEOZ/a7gfeymbFMWmA2CXHdaG+7lQdZQPaX9R0QIDAQAB"
#define RSA_PRIVATE_KEY @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMDZNsRvUVGzxR82Iu+EwN+osDkgGFPyoI8Iis5xGTcTVKsMHuE7WnCcnZxmZt1goKWVNi0keagMo03e/oYS66jp1nyQPds9bt8MCuqHfYWCWuftkea9h0I7ozV1OmAwvGNFhcoQ5n9ruB97KZsUxaYDYJcd1ob7uVB1lA9pf1HRAgMBAAECgYA5XaP8BP0Up7xAj5MO2teg8IYTSCfUeP0n7yuTQ3Nzva1XAFEDQOujSgNcbd21hrPi7aLjBNGnmrLNTEM8UM6GuJDR5vg9xt+NmLLQZvy63/2VTYqRxjAODpC5jeZxGmQiTGY3Xz9Gi4zlpL7bNYB62V8+Gt70k0u1S3iq/TGB/QJBAPkzEWw1naQjqaA+uhm0ml1nWwb7eg3QZDrVyR0ZKlvukNxrA+2EkcHSK7qazTC8DrFNCAC9ReBzymZxHWP2Rb8CQQDGHHjrJPMWuOP5zAscjRsk1x3fJMegLpJHQZVipe5YXbjFTscrZb0/9cXtfM0tTXatbnnMtNTR/mHXAz1fVexvAkEAwZ6UIudlnGq5GPCj1+UjKv9rEnnB04ne1nfU0u8ConsxwpDDdIBUX6vUniA43WzAXbHkTe7BpCtTT1UD6O8oMQJAYDvWdQsG1mPLwjzerOjSZavlQ87e9a2JuvldsoS96cjlB1tEHo2WR6qAkeNM25PEcWy317uDodo69rIJLvVTGwJATTf+evNtxDQVk4p0q57sArAHHDRUYOIRaZIP8QI8bY0f9Twcue4+F67Gs6aPC2H6rChiu9TWRHtq1SvWlUFwug=="


void base64Test_str() {
    NSString *origin = @"111";
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

void tripleDES_test() {
    NSLog(@"--------------------3DES--------------------");
    
    NSArray *contents = @[@"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",@{@"name":@"cx",@"gender":@(1)},@[@"ddd",@"eee",@"aaa",@(33)]];
    for (id obj in contents) {
        NSString *res = [EncryptManager tripleDESEncrypt:obj];
        NSString *dec = [EncryptManager tripleDESDecrypt:res];
        NSLog(@"\n明文[%@]：%@\n密文：%@\r\n解密[%@]：%@\n\n",[obj class],obj,res,[dec class],dec);
    }
    
}

void rsa_test() {
    NSLog(@"--------------------RSA--------------------");
    NSArray *contents = @[@"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",@{@"name":@"cx",@"gender":@(1)},@[@"ddd",@"eee",@"aaa",@(33)]];
    for (id obj in contents) {
        //wItpJ7jQCkAQy5aDAZ97q4LLO254fmZySwxS5KDOVujH12cverieizuvpYqtSVDx/jmnZo3PN2ObaTMO+Ic1XHNu1INImESG2telccRVRbK/ivDWYDmrJQAspUZFR9mC3/adlDKfS9Wy8e730YXO6Jwry5xZCB6pbJg0KdG/w+8=
        NSString *res = [EncryptManager rsaEncrypt:obj publicKey:RSA_PUBLIC_KEY];
//        NSString *res = [RSAUtil encryptString:obj publicKey:RSA_PUBLIC_KEY];
        
        NSString *dec = [EncryptManager rsaDecrypt:res privateKey:RSA_PRIVATE_KEY];
//        NSString *dec = [RSAUtil decryptString:res privateKey:RSA_PRIVATE_KEY];
        NSLog(@"\n明文[%@]：%@\n密文：%@\r\n解密[%@]：%@\n\n",[obj class],obj,res,[dec class],dec);
    }
}

int main(int argc, char * argv[]) {
    tripleDES_test();
    rsa_test();
    return 0;
}



