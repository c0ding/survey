//
//  DRCookiesManager.h
//  SPV
//
//  Created by 张逸阳 on 2018/6/27.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kQsrCookie @"kQsrCookie"
@interface DRCookiesManager : NSObject

+ (void)saveCookies;
+ (void)loadCookies;
@end
