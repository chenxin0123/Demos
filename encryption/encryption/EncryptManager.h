//
//  main.m
//  3DES研究
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface EncryptManager : NSObject

+ (NSString *)tripleDESEncrypt:(id)encryptObj;
+ (id)tripleDESDecrypt:(NSString *)decryptObj;


+ (NSString *)rsaEncrypt:(id)encryptObj publicKey:(NSString *)key;
+ (id)rsaDecrypt:(NSString *)decryptObj privateKey:(NSString *)key;
@end
