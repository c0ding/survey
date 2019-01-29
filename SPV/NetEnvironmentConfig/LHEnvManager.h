//
//  LHEnvManager.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/29.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHEnvManager : NSObject


+ (LHEnvManager *)shareManager;

/// 取当前url。返回：地址
- (NSString *)getCurrentUrl;

- (void)showSwitch;


@end
