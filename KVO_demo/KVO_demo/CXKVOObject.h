//
//  CXKVOObject.h
//  KVO_demo
//
//  Created by CX on 6/12/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXKVOObject : NSObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign,getter=isBoy) BOOL boy;
@end
