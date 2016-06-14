//
//  ObjHashA.m
//  Equal_Hash
//
//  Created by CX on 5/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ObjHashA.h"

@implementation ObjHashA

- (BOOL)isEqualToObjHashA:(ObjHashA *)object {
    return self.hash_V == object.hash_V;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    } else {
        return [self isEqualToObjHashA:other];
    }
}

- (NSUInteger)hash
{
    
    NSUInteger hash = [super hash];
//    NSUInteger hash = self.hash_V;
    NSLog(@"hash is %@",@(hash));
    
    return hash;
}

- (id)copyWithZone:(NSZone *)zone {
    Class cls = [self class];
    typeof(self) obj = [cls new];
    obj.hash_V = self.hash_V;
    return obj;
}


@end
