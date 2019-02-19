//
//  DRCookiesManager.m
//  SPV
//
//  Created by 张逸阳 on 2018/6/27.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRCookiesManager.h"

@implementation DRCookiesManager
+ (void)saveCookies {
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cookiesData forKey:kQsrCookie];
    [defaults synchronize];
}

/// 加载Cookie 
+ (void)loadCookies {
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kQsrCookie]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies)
    {
        [cookieStorage setCookie:cookie];
    }
}


@end
