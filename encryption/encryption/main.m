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

#define rsa_512
#ifndef rsa_512

//#define RSA_PUBLIC_KEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDA2TbEb1FRs8UfNiLvhMDfqLA5IBhT8qCPCIrOcRk3E1SrDB7hO1pwnJ2cZmbdYKCllTYtJHmoDKNN3v6GEuuo6dZ8kD3bPW7fDArqh32Fglrn7ZHmvYdCO6M1dTpgMLxjRYXKEOZ/a7gfeymbFMWmA2CXHdaG+7lQdZQPaX9R0QIDAQAB"
//#define RSA_PRIVATE_KEY @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMDZNsRvUVGzxR82Iu+EwN+osDkgGFPyoI8Iis5xGTcTVKsMHuE7WnCcnZxmZt1goKWVNi0keagMo03e/oYS66jp1nyQPds9bt8MCuqHfYWCWuftkea9h0I7ozV1OmAwvGNFhcoQ5n9ruB97KZsUxaYDYJcd1ob7uVB1lA9pf1HRAgMBAAECgYA5XaP8BP0Up7xAj5MO2teg8IYTSCfUeP0n7yuTQ3Nzva1XAFEDQOujSgNcbd21hrPi7aLjBNGnmrLNTEM8UM6GuJDR5vg9xt+NmLLQZvy63/2VTYqRxjAODpC5jeZxGmQiTGY3Xz9Gi4zlpL7bNYB62V8+Gt70k0u1S3iq/TGB/QJBAPkzEWw1naQjqaA+uhm0ml1nWwb7eg3QZDrVyR0ZKlvukNxrA+2EkcHSK7qazTC8DrFNCAC9ReBzymZxHWP2Rb8CQQDGHHjrJPMWuOP5zAscjRsk1x3fJMegLpJHQZVipe5YXbjFTscrZb0/9cXtfM0tTXatbnnMtNTR/mHXAz1fVexvAkEAwZ6UIudlnGq5GPCj1+UjKv9rEnnB04ne1nfU0u8ConsxwpDDdIBUX6vUniA43WzAXbHkTe7BpCtTT1UD6O8oMQJAYDvWdQsG1mPLwjzerOjSZavlQ87e9a2JuvldsoS96cjlB1tEHo2WR6qAkeNM25PEcWy317uDodo69rIJLvVTGwJATTf+evNtxDQVk4p0q57sArAHHDRUYOIRaZIP8QI8bY0f9Twcue4+F67Gs6aPC2H6rChiu9TWRHtq1SvWlUFwug=="
#else
#define RSA_PUBLIC_KEY @"MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANL/0BOXaWcpJBKjZQGsGRE4eSARalQLuz2rGEPJ76QrSFbpZRozKHxCMihvY+dw50T5XF3cRD7wNE7m4uFPvDsCAwEAAQ=="
#define RSA_PRIVATE_KEY @"MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA0v/QE5dpZykkEqNlAawZETh5IBFqVAu7PasYQ8nvpCtIVullGjMofEIyKG9j53DnRPlcXdxEPvA0Tubi4U+8OwIDAQABAkASmWwtHe6zokPExNR1hkcbZn/+3KojyHjz4a4c46MVNHaMbzk4YYSVgn/8MmQOV7YqCsmb+v6C59Sx7PyNdGnBAiEA68pSGpe/aenOeYOVzjAeg7Mi82Bu75jvgwXyAeYI9BsCIQDlFYfAlCUW1/n4P1rhgRebSGl1UcYGWcSe8y3vAmmaYQIgRjjlJuJWsXZedbYIoXWXQOXS3OS1ZUoI2t6kaohV1k0CIQChWTO/GNiyqTW/emf5MmI9FZhpcEoISQuqZF7y24EjoQIgbsyGEeF+om4bDeB0leFI7jgcH0wxzpq+okJop8sUedk="
#endif

void base64Test_str() {
    NSString *origin = @"012";
    NSString *base64 = [origin base64EncodedString];
    NSLog(@"%@:%@",[base64 base64DecodedString],base64);
}

void base64Test_dic() {
    NSDictionary *dic = @{@"id":@"221"};
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
        
        NSData *data = objectToData(obj);
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString *res = [EncryptManager rsaEncrypt:str publicKey:RSA_PUBLIC_KEY];
        NSString *dec = [EncryptManager rsaDecrypt:res privateKey:RSA_PRIVATE_KEY];
        NSLog(@"\n明文[%@]：%@\n密文：%@\r\n解密[%@]：%@\n\n",[obj class],obj,res,[dec class],dec);
    }
}

static NSData *base64StringToData(NSString *base64String) {
    return [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

void xxx() {
    NSString *x = @"SA44HBhUjDtLxYzzTAQPeg==";
    NSData *data = base64StringToData(x);
    NSLog(@"%@",dataToObject([EncryptManager tripleDesEncryptOrDecryptData:data encrypt:NO]));
}

int main(int argc, char * argv[]) {
//    tripleDES_test();
//    rsa_test();
//    base64Test_str();
    
    base64Test_dic();
    
    return 0;
}



