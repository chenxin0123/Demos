//
//  main.m
//  3DES研究
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EncryptManager.h"
#import <CommonCrypto/CommonDigest.h>  
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

#define gkey @"akfjdkidfssejkddfsdfodjdakfjdkidfssejkddfsdfodjd"

#define giv  @"afsdfsdfafsdfsdf"

@implementation EncryptManager

NSData *hexStringToData(NSString *hexString){
    long len = [hexString length] / 2;
    unsigned char *buf = malloc(len);
    char byte_chars[3] = {'\0','\0','\0'};
    
    for (int i=0; i < len; i++) {
        byte_chars[0] = [hexString characterAtIndex:i*2];
        byte_chars[1] = [hexString characterAtIndex:i*2+1];
        buf[i] = strtol(byte_chars, NULL, 16);
    }
    
    return [NSData dataWithBytes:buf length:len];
}

NSString *dataToHexString(NSData *data) {
    char *chars = (char *)data.bytes;
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for(NSUInteger i = 0; i < data.length; i++ ) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    }
    
    return hexString;
}

#pragma mark - 3DES
+ (NSString*)doDecEncrypt:(NSString *)hexString{
    NSData *data = [self tripleDesEncryptOrDecryptData:hexStringToData(hexString) encrypt:NO];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString *)doEncrypt:plainText{
    NSData *data = [self tripleDesEncryptOrDecryptData:[plainText dataUsingEncoding:NSUTF8StringEncoding] encrypt:YES];
    return dataToHexString(data);
}

+ (NSData *)tripleDesEncryptOrDecryptData:(NSData *)data encrypt:(BOOL)encrypt {
    const void *vkey = (const void *) hexStringToData(gkey).bytes;
    const void *iv = (const void *) hexStringToData(giv).bytes;
    
    CCCryptorStatus ccStatus;
    size_t movedBytes = 0;
    size_t bufferPtrSize = (data.length + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    void *bufferPtr = malloc( bufferPtrSize * sizeof(char *));
    
    ccStatus = CCCrypt(encrypt?kCCEncrypt:kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       iv,
                       data.bytes,
                       data.length,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *resultData = [NSData dataWithBytes:bufferPtr length:movedBytes];
    free(bufferPtr);
    
    return resultData;
}
@end
