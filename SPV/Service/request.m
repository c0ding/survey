//
//  request.m
//  SPV
//
//  Created by hejiahuan on 2017/3/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//
#import "HJUserModel.h"
#import "request.h"
#import "MJExtension.h"
#import "LHEnvManager.h"
#define _CMD_ @"obj"
#define _CMDE_ @"baseApiResult"
//NSString *combineUrl(NSString *cmd){
//    return [NSString stringWithFormat:@"%@%@",HTTPURL,cmd];
//}

NSString *combineUrl(NSString *cmd) {
//#ifdef DEBUG
//    return [NSString stringWithFormat:@"%@%@",[[LHEnvManager shareManager] getCurrentUrl],cmd];
//#else
//    return [NSString stringWithFormat:@"%@%@",HTTPURL,cmd];
//#endif
    
    return [NSString stringWithFormat:@"%@%@",[[LHEnvManager shareManager] getCurrentUrl],cmd];
}
@implementation request

# pragma -mark 张逸阳
# pragma mark - 版本更新

@end


