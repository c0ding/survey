//
//  DRPersonalCenterModel.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/21.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRPersonalCenterModel.h"

@implementation DRPersonalCenterModel


static DRPersonalCenterModel *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(instancetype)shareDRPersonalCenterModel {
    return [[self alloc]init];
}

-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end


@implementation DRPersonalCenterModelObj

@end
