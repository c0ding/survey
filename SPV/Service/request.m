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

- (void)loginWithParams:(NSMutableDictionary *)params net:(dataResponse)net error:(errorResponse) error handleErrorCode:(handleErrorCodeReponse)errorCode {
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
    [params setObject:deviceToken?:@"simulator-deviceToken" forKey:@"deviceToken"];
    [params setObject:@"iOS" forKey:@"platform"];
    NSString *UUIDString = [FCUUID uuidForDevice];
    [params setObject:UUIDString?:@"" forKey:@"uuid"];
    RequestParam *param = [RequestParam create:combineUrl(@"dueDiligence/login")
                                         param:params
                                           cmd:@"post"
                                          type:CACHE_NONE];
    
    GetData(param,
            nil ,nil,
            ^(NSDictionary *jsonData,RequestResult *reslut){
                DRBaseModel *model = [DRBaseModel mj_objectWithKeyValues:jsonData];
                if (net) {
                    net(model, reslut);
                }
            },
            ^(RequestResult *err){
                if (err.errcode==500) {
                    if (errorCode) {
                        errorCode(err.errcode);
                    }
                    return ;
                }
                if(error) error(err);
            });
}

- (void)logoutWithParams:(NSMutableDictionary *)params net:(dataResponse)net error:(errorResponse) error handleErrorCode:(handleErrorCodeReponse)errorCode {
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
    [params setObject:deviceToken?:@"simulator-deviceToken" forKey:@"deviceToken"];
    [params setObject:@"iOS" forKey:@"platform"];
    NSString *UUIDString = [FCUUID uuidForDevice];
    [params setObject:UUIDString?:@"" forKey:@"uuid"];
    RequestParam *param = [RequestParam create:combineUrl(@"dueDiligence/logout")
                                         param:params
                                           cmd:@"post"
                                          type:CACHE_NONE];
    
    GetData(param,
            nil ,nil,
            ^(NSDictionary *jsonData,RequestResult *reslut){
                DRBaseModel *model = [DRBaseModel mj_objectWithKeyValues:jsonData];
                if (net) {
                    net(model, reslut);
                }
            },
            ^(RequestResult *err){
                if (err.errcode==500) {
                    if (errorCode) {
                        errorCode(err.errcode);
                    }
                    return ;
                }
                if(error) error(err);
            });
}

@end


