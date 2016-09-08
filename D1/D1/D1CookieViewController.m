//
//  D1CookieViewController.m
//  D1
//
//  Created by CX on 9/8/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "D1CookieViewController.h"
#import "AFNetworking.h"

@interface D1CookieViewController ()

@end

@implementation D1CookieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self logCookie];
    [self test];
}


- (void)test {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *task = [manager GET:@"http://shop.oybus.com/shop.php/Shop/index" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /**
         <NSHTTPCookie version:0 name:"PHPSESSID" value:"ibhof2h7cu05ppmd5764smti81" expiresDate:(null) created:2016-09-08 15:00:54 +0000 sessionOnly:TRUE domain:"shop.oybus.com" path:"/" isSecure:FALSE>
         */
        [self logCookie];
        NSHTTPCookie *cookie = [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] firstObject];
        NSMutableDictionary *pros = cookie.properties.mutableCopy;
        pros[NSHTTPCookieExpires] = [NSDate dateWithTimeIntervalSinceNow:9999];
        NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:pros];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        [self logCookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newCookie];
        [self logCookie];
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
        //存储归档后的cookie
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject: cookiesData forKey: @"cookie"];
        NSLog(@"\n");
        
        [self deleteCookie];
        [self setCoookie];
    } failure:nil];
    [task resume];
}

- (void)logCookie {
    NSLog(@"============Log Cookie===============");
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        NSLog(@"%@\n", tempCookie);
    }
}

#pragma mark 删除cookie
- (void)deleteCookie
{
    NSLog(@"============删除cookie===============");
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    
    //把cookie打印出来，检测是否已经删除
    NSArray *cookiesAfterDelete = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookiesAfterDelete) {
        NSLog(@"cookieAfterDelete:\n %@", tempCookie);
    }
    NSLog(@"\n");
}

#pragma mark 再取出保存的cookie重新设置cookie
- (void)setCoookie
{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    
    if (cookies) {
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
    [self logCookie];
    NSLog(@"\n");
}

@end
