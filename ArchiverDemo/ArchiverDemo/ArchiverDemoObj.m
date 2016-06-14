//
//  ArchiverDemoObj.m
//  ArchiverDemo
//
//  Created by xian on 6/14/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ArchiverDemoObj.h"

@interface ArchiverDemoObj ()<NSCoding>

@end

@implementation ArchiverDemoObj

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.value = [decoder decodeDoubleForKey:@"value"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeDouble:self.value forKey:@"value"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"value:%@",@(self.value)];
}

@end
