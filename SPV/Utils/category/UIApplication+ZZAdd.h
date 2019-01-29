//
//  UIApplication+ZZAdd.h
//  SPV
//
//  Created by zyy on 2017/9/14.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIApplication+YYAdd.h"


#define ZZSharedApplication ([UIApplication sharedApplication])

@interface UIApplication (ZZAdd)

@property (nullable, nonatomic, readonly) NSString *appDisplayName;
@property (nullable, nonatomic, readonly) NSString *deviceModelIdentifier;
- (nullable UIViewController *)getRootViewController;

/**
 当前推送权限

 @return 是否开启推送
 */
- (BOOL)currentUserNotificationState;
/**
 拨打电话
 
 @param telNumber 电话号码
 */
- (void)openTel:(NSString *__nonnull)telNumber;

/**
 打开邮箱

 @param email 邮箱地址
 */
- (void)openEmail:(NSString *__nonnull)email;

/**
 跳转到应用权限设置页面
 
 @param title   提示
 @param message 描述
 */
- (void)openSettingsURLWithTitle:(NSString *__nonnull)title withMessage:(NSString *__nonnull)message;


/**
 打开定位
 */
- (void)openLocationAuthority;

/**
 打开照片
 */
- (void)openPhotoAuthority;

/**
 打开相机
 */
- (void)openCameraAuthority;

/**
 打开通讯录
 */
- (void)openAddressBookAuthority;

/**
 根据iOS版本选择最新的api跳转 options为nil，completionHandler为nil
 
 @param string 跳转的连接字符串
 */
- (void)openURLWithString:(NSString * __nonnull )string;

/**
 根据iOS版本选择最新的api跳转
 
 @param string     跳转的连接字符串
 @param options    UIApplicationOpenURLOptionUniversalLinksOnly，默认NO，http://one9398.com/2016/09/25/iOS10%E6%96%B0%E5%8F%98%E5%8C%96%E4%B9%8B%E5%BA%9F%E5%BC%83%E7%9A%84openURL/
 @param completion 完成跳转动作 success标记
 */
- (void)openURLWithString:(NSString * __nonnull )string options:(NSDictionary<NSString *,id> * __nullable)options completionHandler:(void (^__nullable)(BOOL success))completion;
@end
