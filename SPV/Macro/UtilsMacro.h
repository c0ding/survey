//
//  UtilsMacro.h
//  QIAO
//
//  Created by codi on 17/2/8.
//  Copyright © 2017年 zyy. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//网络状态监控地址
static NSString* const kURL_Reachability__Address=@"www.baidu.com";

/* -------------- 简写 ---------------- */
#define singleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)

#define singleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}
#else
#define singleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif



#define DRSharedApplication ([UIApplication sharedApplication])
#define WEAKSELF typeof(self) __weak __block weakSelf = self;
#define STRONGSELF typeof(self) __strong strongSelf = weakSelf;

/** 获取通知中心*/
#define RFNotificationCenter [NSNotificationCenter defaultCenter]

/** GCD 的宏定义*/
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

/* -------------- 系统 ---------------- */

/** 获取系统版本*/
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/** 获取当前语言*/
#define LRCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 是否为iOS7及以上系统*/
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/** 是否为iOS8及以上系统*/
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
/** 是否为iOS10及以上系统*/
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

/** 沙盒目录文件*/
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



/** 判断是真机还是模拟器*/
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

/* -------------- 颜色 ---------------- */

/** clear背景颜色*/
#define RFClearColor [UIColor clearColor]

/** 输入 rgb 的值，获取颜色*/
#define RFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 随机颜色*/
#define RFRandomColor RFColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


/* -------------- 尺寸 ---------------- */

///** 判断设备类型*/
//#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
//#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
//
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//
//
////基于6的适配
//#define kWidth(R) (R)*(kScreenWidth)/375
//#define kHeight(R) (iPhone4?((R)*(kScreenHeight)/568):((R)*(kScreenHeight)/667))
//#define font(R) (R)*(kScreenWidth)/375
//#define kFONT16   [UIFont systemFontOfSize:font(16.0f)]

/** 导航栏高度*/
#define RFNavigationHeight CGRectGetMaxY([self.navigationController navigationBar].frame)

/** 当前Xcode支持iOS8及以上*/
#if  IOS_VERSION_8_OR_LATER
/** 屏幕高度*/
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
/** 屏幕宽度*/
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
/** 屏幕尺寸*/
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size



#endif

/* -------------- UI ---------------- */


/** 获取图片资源*/
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


/** 设置 view 圆角和边框*/
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 由角度转换弧度 由弧度转换角度*/
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)


#endif /* UtilsMacro_h */
