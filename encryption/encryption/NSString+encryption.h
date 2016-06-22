//
//  NSString+encryption.h
//  encryption
//
//  Created by xian on 6/22/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCryptor.h>

@interface NSString (encryption)

- (NSString *)base64EncodedString;

- (NSString *)base64DecodedString;
@end
