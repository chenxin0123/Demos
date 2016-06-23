//
//  main.m
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

NSData *stripPublicKeyHeader(NSData *d_key);
NSData *stripPrivateKeyHeader(NSData *d_key);

@implementation EncryptManager

NSString *dataToBase64String(NSData *data) {
    data = [data base64EncodedDataWithOptions:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

NSData *base64StringToData(NSString *base64String) {
    return [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

NSData *hexStringToData(NSString *hexString) {
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

NSData *objectToData(id obj) {
    NSData *data = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    } else if ([obj isKindOfClass:[NSData class]]) {
        data = obj;
    }
    return data;
}

id dataToObject(NSData *data) {
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
    if (!result) {
        result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }

    return result;
}

#pragma mark - 3DES

+ (NSString *)tripleDESEncrypt:(id)encryptObj {
    NSData *data = [self tripleDesEncryptOrDecryptData:objectToData(encryptObj) encrypt:YES];
    return dataToHexString(data);
}

+ (id)tripleDESDecrypt:(NSString *)decryptObj {
    NSData *data = [self tripleDesEncryptOrDecryptData:hexStringToData(decryptObj) encrypt:NO];
    return dataToObject(data);
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

#pragma mark - RSA
SecKeyRef createSeckeyWithKey(NSString *key, BOOL isPrivate){
    
    
    NSMutableDictionary *keyQuery = [@{
                                     (__bridge id)kSecClass:(__bridge id)kSecClassKey,
                                     (__bridge id)kSecAttrKeyType:(__bridge id)kSecAttrKeyTypeRSA
                                     } mutableCopy];
    NSString *kTag = isPrivate?@"RSA_PRIVATE_KEY_TAG":@"RSA_PUBLIC_KEY_TAG";
    keyQuery[(__bridge id)kSecAttrApplicationTag] = [NSData dataWithBytes:[kTag UTF8String] length:[kTag length]];
    
    SecItemDelete((__bridge CFDictionaryRef)keyQuery);
    
    keyQuery[(__bridge id)kSecValueData] = isPrivate? stripPrivateKeyHeader(base64StringToData(key)):stripPublicKeyHeader(base64StringToData(key));
    keyQuery[(__bridge id)kSecAttrKeyClass] = (__bridge id)(isPrivate?kSecAttrKeyClassPrivate:kSecAttrKeyClassPublic);
    keyQuery[(__bridge id)kSecAttrKeyType] = (__bridge id) kSecAttrKeyTypeRSA;
    keyQuery[(__bridge id)kSecReturnRef] = [NSNumber numberWithBool:YES];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)keyQuery, nil);
    
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)keyQuery, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

NSData *stripPublicKeyHeader(NSData *d_key) {
    // Skip ASN.1 public key header
    if (!d_key || !d_key.length) return nil;
    
    unsigned long len = [d_key length];
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    //00110000
    if (c_key[idx++] != 0x30) return nil;
    //10000000
    if (c_key[idx] > 0x80) {
        idx += c_key[idx] - 0x80 + 1;
    } else {
        idx++;
    }
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] = { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return nil;
    idx += 15;
    
    if (c_key[idx++] != 0x03) return nil;
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return nil;
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

//credit: http://hg.mozilla.org/services/fx-home/file/tip/Sources/NetworkAndStorage/CryptoUtils.m#l1036
NSData *stripPrivateKeyHeader(NSData *d_key) {
    
    if (!d_key || !d_key.length) return nil;
    
    // Skip ASN.1 private key header
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    //This is some crazy magic byte that indicates it's actually ASN.1
    unsigned int  idx	 = 22;
    
    //0x04 is the DER indicator for an octet string
    if (0x04 != c_key[idx++]) return nil;
    
    //now we need to find out how long the key is, so we can extract the correct hunk of bytes from the buffer.
    unsigned int c_len = c_key[idx++];
    
    //is the high bit set? 10000000
    int det = c_len & 0x80;

    // no?  then the length of the key is a number that fits in one byte, (< 128)
    //otherwise, the length of the key is a number that doesn't fit in one byte (> 127)
    if (det){
        //so we need to snip off byteCount bytes from the front, and reverse their order
        unsigned int byteCount = c_len & 0x7f;
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (NSString *)rsaEncrypt:(id)encryptObj publicKey:(NSString *)key {
    if (!encryptObj || !key) {
        return nil;
    }
    NSData *data = objectToData(encryptObj);
    SecKeyRef keyRef = createSeckeyWithKey(key,NO);
    if (!keyRef) {
        return nil;
    }
    
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    // this is the size of the modulus
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    
    //kSecPaddingPKCS1
    size_t src_block_size = block_size - 11;
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    OSStatus status = noErr;
    
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t outlen = block_size;
        status = SecKeyEncrypt(keyRef,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               MIN(srclen - idx, src_block_size),
                               outbuf,
                               &outlen
                               );
        if (status != noErr) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            return nil;
        }
        [encryptedData appendBytes:outbuf length:outlen];
    }
    
    free(outbuf);
    CFRelease(keyRef);
    
    return dataToHexString(encryptedData);
}

+ (id)rsaDecrypt:(NSString *)decryptObj privateKey:(NSString *)key {
    
    NSData *data = hexStringToData(decryptObj);
    SecKeyRef keyRef = createSeckeyWithKey(key,YES);
    
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    OSStatus status = noErr;
    
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t outlen = block_size;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               MIN(srclen - idx, src_block_size),
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            return nil;
        }else{
            //kSecPaddingPKCS1使用随机非0值
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for (int i=0; i<outlen; i++) {
                if (outbuf[i] == 0) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return dataToObject(ret);
}

@end
