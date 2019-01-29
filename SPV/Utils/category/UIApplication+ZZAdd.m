//
//  UIApplication+ZZAdd.h
//  SPV
//
//  Created by zyy on 2017/9/14.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "UIApplication+ZZAdd.h"
//#import "ZZAlertController.h"
//#import "UIDevice+ZZAdd.h"
#import <sys/utsname.h>
@implementation UIApplication (ZZAdd)


- (BOOL)currentUserNotificationState {
    BOOL isOpen = NO;
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types != UIUserNotificationTypeNone) {
        isOpen = YES;
    }
    return isOpen;
}
- (NSString *)appDisplayName {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
}

- (NSString *)deviceModelIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *machine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([machine isEqual:@"iPad1,1"])
        return @"iPad";
    else if ([machine isEqual:@"iPad2,1"])
        return @"iPad 2";
    else if ([machine isEqual:@"iPad2,2"])
        return @"iPad 2";
    else if ([machine isEqual:@"iPad2,3"])
        return @"iPad 2";
    else if ([machine isEqual:@"iPad2,4"])
        return @"iPad 2";
    else if ([machine isEqual:@"iPad3,1"])
        return @"iPad 3";
    else if ([machine isEqual:@"iPad3,2"])
        return @"iPad 3";
    else if ([machine isEqual:@"iPad3,3"])
        return @"iPad 3";
    else if ([machine isEqual:@"iPad3,4"])
        return @"iPad 4";
    else if ([machine isEqual:@"iPad3,5"])
        return @"iPad 4";
    else if ([machine isEqual:@"iPad3,6"])
        return @"iPad 4";
    else if ([machine isEqual:@"iPad4,1"])
        return @"iPad Air";
    else if ([machine isEqual:@"iPad4,2"])
        return @"iPad Air";
    else if ([machine isEqual:@"iPad4,3"])
        return @"iPad Air";
    else if ([machine isEqual:@"iPad5,3"])
        return @"iPad Air 2";
    else if ([machine isEqual:@"iPad5,4"])
        return @"iPad Air 2";
    else if ([machine isEqual:@"iPad6,7"])
        return @"iPad Pro 12.9";
    else if ([machine isEqual:@"iPad6,8"])
        return @"iPad Pro 12.9";
    else if ([machine isEqual:@"iPad6,3"])
        return @"iPad Pro 9.7";
    else if ([machine isEqual:@"iPad6,4"])
        return @"iPad Pro 9.7";
    else if ([machine isEqual:@"iPad2,5"])
        return @"iPad mini";
    else if ([machine isEqual:@"iPad2,6"])
        return @"iPad mini";
    else if ([machine isEqual:@"iPad2,7"])
        return @"iPad mini";
    else if ([machine isEqual:@"iPad4,4"])
        return @"iPad mini 2";
    else if ([machine isEqual:@"iPad4,5"])
        return @"iPad mini 2";
    else if ([machine isEqual:@"iPad4,6"])
        return @"iPad mini 2";
    else if ([machine isEqual:@"iPad4,7"])
        return @"iPad mini 3";
    else if ([machine isEqual:@"iPad4,8"])
        return @"iPad mini 3";
    else if ([machine isEqual:@"iPad4,9"])
        return @"iPad mini 3";
    else if ([machine isEqual:@"iPad5,1"])
        return @"iPad mini 4";
    else if ([machine isEqual:@"iPad5,2"])
        return @"iPad mini 4";
    
    else if ([machine isEqual:@"iPhone1,1"])
        return @"iPhone";
    else if ([machine isEqual:@"iPhone1,2"])
        return @"iPhone 3G";
    else if ([machine isEqual:@"iPhone2,1"])
        return @"iPhone 3GS";
    else if ([machine isEqual:@"iPhone3,1"])
        return @"iPhone 4";
    else if ([machine isEqual:@"iPhone3,2"])
        return @"iPhone 4";
    else if ([machine isEqual:@"iPhone3,3"])
        return @"iPhone 4";
    else if ([machine isEqual:@"iPhone4,1"])
        return @"iPhone 4S";
    else if ([machine isEqual:@"iPhone5,1"])
        return @"iPhone5,2	iPhone 5";
    else if ([machine isEqual:@"iPhone5,3"])
        return @"iPhone5,4	iPhone 5c";
    else if ([machine isEqual:@"iPhone6,1"])
        return @"iPhone6,2	iPhone 5s";
    else if ([machine isEqual:@"iPhone7,2"])
        return @"iPhone 6";
    else if ([machine isEqual:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    else if ([machine isEqual:@"iPhone8,1"])
        return @"iPhone 6s";
    else if ([machine isEqual:@"iPhone8,2"])
        return @"iPhone 6s Plus";
    else if ([machine isEqual:@"iPhone8,4"])
        return @"iPhone SE";
    
    else if ([machine isEqual:@"iPod1,1"])
        return @"iPod touch";
    else if ([machine isEqual:@"iPod2,1"])
        return @"iPod touch 2G";
    else if ([machine isEqual:@"iPod3,1"])
        return @"iPod touch 3G";
    else if ([machine isEqual:@"iPod4,1"])
        return @"iPod touch 4G";
    else if ([machine isEqual:@"iPod5,1"])
        return @"iPod touch 5G";
    else if ([machine isEqual:@"iPod7,1"])
        return @"iPod touch 6G";
    
    else if ([machine isEqual:@"x86_64"])
        return @"simulator 64bits";
    
    // none matched: cf https://www.theiphonewiki.com/wiki/Models for the whole list
    NSLog(@"%s: Oops, unknown machine %@... consider completing me!", __FUNCTION__, machine);
    return machine;
}

- (nullable UIViewController *)getRootViewController {
    return ZZSharedApplication.keyWindow.rootViewController;
}

- (void)openTel:(NSString *__nonnull)telNumber {
    if (telNumber) {
        NSString *telStr = [NSString stringWithFormat:@"telprompt://%@", telNumber];
        telStr = [telStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [ZZSharedApplication openURLWithString:telStr options:nil completionHandler:nil];
    }
}

- (void)openEmail:(NSString *__nonnull)email {
    if (email) {
        NSString *emailStr = [NSString stringWithFormat:@"mailto:%@", email];
        emailStr = [emailStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [ZZSharedApplication openURLWithString:emailStr options:nil completionHandler:nil];
    }
}


//- (void)openSettingsURLWithTitle:(NSString *__nonnull)title withMessage:(NSString *__nonnull)message {
//    [ZZAlertController alertWithMessage:message andTitle:title cancelActionTitle:@"取消" cancelActionBlock:^(UIAlertAction * _Nonnull action) {
//    } defaultActionTitle:@"立即开启" defaultActionBlock:^(UIAlertAction * _Nonnull action) {
//        [[UIApplication sharedApplication] openURLWithString:UIApplicationOpenSettingsURLString options:nil completionHandler:nil];
//    }];
//}

- (void)openLocationAuthority{
    NSString *message = [NSString stringWithFormat:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许“%@”使用定位服务",[UIApplication sharedApplication].appDisplayName];
    [self openSettingsURLWithTitle:@"开启定位权限" withMessage:message];
}

- (void)openPhotoAuthority{
    NSString *message = [NSString stringWithFormat:@"请在iphone的“设置-隐私-照片”选项中，并允许“%@”访问你的照片",ZZSharedApplication.appDisplayName];
    [self openSettingsURLWithTitle:@"开启照片权限" withMessage:message];
}

- (void)openCameraAuthority {
    NSString *message = [NSString stringWithFormat:@"请在iphone的“设置-隐私-相机”选项中，并允许“%@”访问你的相机",ZZSharedApplication.appDisplayName];
    [self openSettingsURLWithTitle:@"开启相机权限" withMessage:message];
}

- (void)openAddressBookAuthority {
    NSString *message = [NSString stringWithFormat:@"请在iphone的“设置-隐私-通讯录”选项中，并允许“%@”访问你的通讯录",ZZSharedApplication.appDisplayName];
    [self openSettingsURLWithTitle:@"开启通讯录权限" withMessage:message];
}

- (void)openURLWithString:(NSString * __nonnull )string options:(NSDictionary<NSString *,id> * __nullable)options completionHandler:(void (^__nullable)(BOOL success))completion {
    NSURL *url = [NSURL URLWithString:string];
    
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        
        if (iOS10) {
            NSDictionary *params = @{};
            if (options && [options isKindOfClass:[NSDictionary class]]) {
                params = options;
            }
            [self openURL:url options:params completionHandler:completion];
            
        } else {
            
            BOOL open = [self openURL:url];
            if (completion) {
                completion(open);
            }
        }
        
    }else {
        if (completion) {
            completion(NO);
        }
    }
}

- (void)openURLWithString:(NSString * __nonnull )string {
    
    [self openURLWithString:string options:nil completionHandler:nil];
}
@end
