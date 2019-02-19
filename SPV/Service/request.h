//
//  request.h
//  SPV
//
//  Created by hejiahuan on 2017/3/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDataInterface.h"
#import "DRLoginModel.h"
#import "DRMockData.h"
#import "DRPersonalCenterModel.h"
#import "DRUpdateVersionModel.h"
#import "DRCollectGetModel.h"
typedef void(^dataResponse)(id data,RequestResult *result);
typedef void(^localResponse)(id data);
typedef void(^errorResponse)(RequestResult *result);
typedef void(^handleErrorCodeReponse)(NSUInteger errorCode);
@interface request : NSObject



- (void)loginWithParams:(NSMutableDictionary *)params net:(dataResponse)net error:(errorResponse) error handleErrorCode:(handleErrorCodeReponse)errorCode;

- (void)logoutWithParams:(NSMutableDictionary *)params net:(dataResponse)net error:(errorResponse) error handleErrorCode:(handleErrorCodeReponse)errorCode;
@end
