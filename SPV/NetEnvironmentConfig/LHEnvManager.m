//
//  LHEnvManager.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/29.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "LHEnvManager.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"
@interface LHEnvManager ()
@end
static NSString *kCachedServicePrefix = @"kCacheServicePrefix";
@implementation LHEnvManager

+ (LHEnvManager *)shareManager {
    static LHEnvManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)showSwitch{
    NSMutableArray *prefixs = [self readConfig].mutableCopy;
    [UIActionSheet showInView:[UIApplication sharedApplication].keyWindow
                    withTitle:@"请选择接口环境"
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:[NSString stringWithFormat:@"当前环境:%@", [self getCurrentUrlName]]
            otherButtonTitles:[self getUrls]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == actionSheet.destructiveButtonIndex || buttonIndex == actionSheet.cancelButtonIndex) {
                return ;
            }
            NSMutableDictionary *selectUrl = prefixs[buttonIndex-1];

            [[[UIAlertView alloc] lh_initWithTitle:@"切换环境"
                                           message:[NSString stringWithFormat:@"是否切换环境到\n%@\n%@",selectUrl[@"netName"],selectUrl[@"netUrl"]]
                                  cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:nil]
                                  otherButtonItems:[RIButtonItem itemWithLabel:@"确定" action:^{
                [self saveUrl2Plist:selectUrl];
                
            }], nil] show];
         
     }
     ];
}


- (void)saveUrl2Plist:(NSMutableDictionary *)selectUrl {
    NSMutableArray *arr = [self readConfig];
    for (NSMutableDictionary *dict in arr) {
        //把原先的选择状态置为NO
        if ([[dict objectForKey:@"isCurrent"] boolValue]) {
            [dict setValue:@NO forKey:@"isCurrent"];
        }
        //把选择的url设置为 当前环境
        if ([[dict objectForKey:@"netName"] isEqualToString:selectUrl[@"netName"]]) {
                dict[@"isCurrent"] = @YES;
        }
    }
    NSString *plistPath = [kPathDocument stringByAppendingPathComponent:@"NetConfig.plist"];
    [arr writeToFile:plistPath atomically:YES];

}

/// 初始化url配置文件至沙盒中
- (void)initNetConfig {
    NSString *plistPath = [kPathDocument stringByAppendingPathComponent:@"NetConfig.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFileExist = [fileManager fileExistsAtPath:plistPath];
    if (!isFileExist) {
//        如果沙盒中没有配置文件，加载工程里的配置文件。
        NSString *path = [[NSBundle mainBundle] pathForResource:@"NetConfig" ofType:@"plist"];
        [[NSArray arrayWithContentsOfFile:path] writeToFile:plistPath atomically:YES];
    }
}


/// 读取沙盒中的url配置文件
- (NSMutableArray *)readConfig {
    NSString *plistPath = [kPathDocument stringByAppendingPathComponent:@"NetConfig.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFileExist = [fileManager fileExistsAtPath:plistPath];
    if (!isFileExist) {
        [self initNetConfig];
    }
    return  [NSMutableArray arrayWithContentsOfFile:plistPath];
}

/// 取当前url。返回：名字+地址
- (NSString *)getCurrentUrlName {
    NSString *currentUrlName;
    for (NSDictionary *dict in [self readConfig]) {
        if ([[dict objectForKey:@"isCurrent"] boolValue]) {
            currentUrlName = [NSString stringWithFormat:@"%@:%@",dict[@"netName"],dict[@"netUrl"]];
        }
    }
    return currentUrlName?:@"";
}

/// 取当前url。返回：当前配置的地址
- (NSString *)getCurrentUrl {
    NSString *currentUrl;
    for (NSDictionary *dict in [self readConfig]) {
        if ([[dict objectForKey:@"isCurrent"] boolValue]) {
            currentUrl = [NSString stringWithFormat:@"%@",dict[@"netUrl"]];
        }
    }
    return currentUrl?:HTTPURL;
}


/// 取所有 url。 返回：名字+地址
- (NSMutableArray<NSString*> *)getUrls {
    NSMutableArray *urlNameArr = [NSMutableArray array];
    for (NSDictionary *dict in [self readConfig]) {
        [urlNameArr addObject:[NSString stringWithFormat:@"%@:%@",dict[@"netName"],dict[@"netUrl"]]];
    }
    return urlNameArr;
}

///// 取出当前url
//- (NSString *)currentServicePrefix {
//    NSString *currentUrlName;
//    for (NSDictionary *dict in [self netUrlPrefixs]) {
//        if ([[dict objectForKey:@"isCurrent"] boolValue]) {
//            currentUrlName = [NSString stringWithFormat:@"%@:%@",dict[@"netName"],dict[@"netUrl"]];
//        }
//    }
//    return currentUrlName?:@"";
//}




///// 配置文件
//- (NSMutableArray *)netUrlPrefixs {
//
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"NetConfig" ofType:@"plist"];
//    NSString *plistPath = [kPathDocument stringByAppendingPathComponent:@"NetConfig.plist"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL isFileExist = [fileManager fileExistsAtPath:plistPath];
//    if (isFileExist) {
//        return  [NSMutableArray arrayWithContentsOfFile:plistPath];
//    }
//    [[NSArray arrayWithContentsOfFile:path] writeToFile:plistPath atomically:YES];
//    return  [NSMutableArray arrayWithContentsOfFile:plistPath];
//}

@end
