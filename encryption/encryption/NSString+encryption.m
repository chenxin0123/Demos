//
//  NSString+encryption.m
//  encryption
//
//  Created by xian on 6/22/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "NSString+encryption.h"


@implementation NSString (encryption)

- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
