//
//  NSDate+DRExtension.h
//  SPV
//
//  Created by 张逸阳 on 2018/1/3.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DRExtension)
/**
 
 *  是否为今天
 
 */

- (BOOL)isToday;

/**
 
 *  是否为昨天
 
 */

- (BOOL)isYesterday;

/**
 
 *  是否为今年
 
 */

- (BOOL)isThisYear;



/**
 
 *  返回一个只有年月日的时间
 
 */

- (NSDate *)dateWithYMD;



/**
 
 *  获得与当前时间的差距
 
 */

- (NSDateComponents *)deltaWithNow;
@end
