//
//  main.m
//  ArchiverDemo
//
//  Created by xian on 6/14/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiverDemoObj.h"
int main(int argc, const char * argv[]) {
        
//    NSMutableArray *list = [NSMutableArray array];
    
    ArchiverDemoObj *o1 = [ArchiverDemoObj new];
    o1.value = 13211;
    ArchiverDemoObj *o2 = [ArchiverDemoObj new];
    o2.value = 227244;
//    [list addObject:o1];
//    [list addObject:o2];
    NSArray *list = @[o1,o2];
    
    
    NSString *dir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"a/b/c/d/e.cx"];
    
    NSString *path = [dir stringByAppendingPathComponent:@"file"];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
    }else {
        NSLog(@"dir exist");
    }
    
    if (error) {
        NSLog(@"error:%@",error);
    }
    
    NSLog(@"%@",[[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error]);
    
    
    if ([NSKeyedArchiver archiveRootObject:list toFile:path]) {
        NSLog(@"success");
    }else {
        NSLog(@"fail");
    }
    
    id x = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"%@ %@",list,x);
    
    return 0;
}
