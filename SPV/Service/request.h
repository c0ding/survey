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
typedef void(^dataResponse)(id data,RequestResult *result);
typedef void(^localResponse)(id data);
typedef void(^errorResponse)(RequestResult *result);
typedef void(^handleErrorCodeReponse)(NSUInteger errorCode);
@interface request : NSObject
#pragma -mark 张逸阳



@end
