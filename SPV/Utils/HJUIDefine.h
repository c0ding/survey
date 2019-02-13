//
//  HJUIDefine.h
//  thrallplus
//
//  Created by hxt on 16/9/9.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppMacro.h"
#import "NotificationMacro.h"
#import "VendorMacro.h"
#import "UtilsMacro.h"

@interface HJUIDefine : NSObject

#define White ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]) // ffffff

#define Yellow ([UIColor colorWithRed:223/255.0 green:178/255.0 blue:72/255.0 alpha:1]) // dfb248

#define LightYellow ([UIColor colorWithRed:255/255.0 green:186/255.0 blue:0/255.0 alpha:1]) //ffba00

#define LLGray ([UIColor colorWithRed:230/255.0 green:228/255.0 blue:226/255.0 alpha:1]) // e6e4e2

#define LightGray ([UIColor colorWithRed:200/255.0 green:195/255.0 blue:190/255.0 alpha:1]) // c8c3be

#define Gray ([UIColor colorWithRed:135/255.0 green:132/255.0 blue:129/255.0 alpha:1]) // 878481

#define Black ([UIColor colorWithRed:15/255.0 green:15/255.0 blue:15/255.0 alpha:1]) // 0f0f0f

#define BackBlack ([UIColor colorWithRed:55/255.0 green:52/255.0 blue:50/255.0 alpha:1]) // 373432

#define Blue ([UIColor colorWithRed:141/255.0 green:145/255.0 blue:177/255.0 alpha:1]) // 8d91b1

#define LightBlue ([UIColor colorWithRed:0/255.0 green:102/255.0 blue:255/255.0 alpha:1]) // 0066ff

#define MilkWhite ([UIColor colorWithRed:246/255.0 green:245/255.0 blue:242/255.0 alpha:1]) //f6f5f2

#define LightRed ([UIColor colorWithRed:249/255.0 green:93/255.0 blue:91/255.0 alpha:1]) // f95d5b

#define Red ([UIColor colorWithRed:255/255.0 green:4/255.0 blue:4/255.0 alpha:1]) // ff0404

#define Green ([UIColor colorWithRed:32/255.0 green:182/255.0 blue:3/255.0 alpha:1]) // 20b603

#define LightCyan ([UIColor colorWithRed:248/255.0 green:249/255.0 blue:248/255.0 alpha:1]) // f8f9f8

#define BorderColor ([UIColor colorWithRed:255/255.0 green:232/255.0 blue:150/255.0 alpha:1]) // ffe896

#define BgColor ([UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]) // fafafa

#define Pink ([UIColor colorWithRed:244/255.0 green:144/255.0 blue:165/255.0 alpha:1]) // f490a5

#define LBlue ([UIColor colorWithRed:82/255.0 green:96/255.0 blue:171/255.0 alpha:1]) // 5260ab

#define DarkBlue ([UIColor colorWithRed:54/255.0 green:69/255.0 blue:150/255.0 alpha:1]) // 364596
#define TextBlue ([UIColor colorWithRed:186/255.0 green:194/255.0 blue:137/255.0 alpha:1]) // bac2ed


#define Font10 ([UIFont systemFontOfSize:10])

#define Font12 ([UIFont systemFontOfSize:12])

#define Bold12 ([UIFont boldSystemFontOfSize:12])

#define Bold13 ([UIFont boldSystemFontOfSize:13])

#define Font14 ([UIFont systemFontOfSize:14])

#define Bold14 ([UIFont boldSystemFontOfSize:14])

#define Font15 ([UIFont systemFontOfSize:15])

#define Bold15 ([UIFont boldSystemFontOfSize:15])

#define Font17 ([UIFont systemFontOfSize:17])

#define Bold17 ([UIFont boldSystemFontOfSize:17])

#define Bold19 ([UIFont boldSystemFontOfSize:19])

#define Font20 ([UIFont systemFontOfSize:20])

#define Bold20 ([UIFont boldSystemFontOfSize:20])

#define Font34 ([UIFont systemFontOfSize:34])

#define Bold34 ([UIFont boldSystemFontOfSize:34])

#define Bold40 ([UIFont boldSystemFontOfSize:40])

//#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define APPID_VALUE           @"5a5effa6"
#define  statusHeight  [[UIApplication sharedApplication] statusBarFrame].size.height;
#define  navigationHeight  self.navigationController.navigationBar.frame.size.height;
#define  tabBarHeight  self.tabBar.frame.size.height;
#define  toolBarHeight  self.navigationController.toolBar.frame.size.height;




#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 判断设备类型*/
#define iPhone10 ([UIScreen mainScreen].bounds.size.height == 812)
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//基于6的适配
#define kWidth(R) (R)*(kScreenWidth)/375
//#define kHeight(R) (iPhone10?((R)*(kScreenHeight)/667):iPhone4?((R)*(kScreenHeight)/568):((R)*(kScreenHeight)/667))

#define kHeight(R) (iPhone10?((R)*(kScreenHeight)/812):iPhone4?((R)*(kScreenHeight)/568):((R)*(kScreenHeight)/667))

#define font(R) (R)*(kScreenWidth)/375
#define kFONT16   [UIFont systemFontOfSize:font(16.0f)]

#define WEAKSELF typeof(self) __weak __block weakSelf = self;
#define STRONGSELF typeof(self) __strong strongSelf = weakSelf;
/** 获取图片资源*/
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

extern NSAttributedString *numToChangeFont(NSString *string,NSUInteger len1, NSUInteger len2, CGFloat fontSize);

extern NSString *mobileStyle(NSString *mobile);

extern NSAttributedString *numToChangeColor(NSString *string,NSUInteger len1, NSUInteger len2, UIColor *color);

@end
