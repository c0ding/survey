//
//  DRMockData.h
//  SPV
//
//  Created by 张逸阳 on 2018/7/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRMockData : NSObject
+(instancetype)shareDRMockData;
///案件详情与状态
- (NSDictionary *)lawCaseMock;

///债权主页
- (NSDictionary *)obligatoryRightsMock;
///版本更新
- (NSDictionary *)updateVersionMock;

/// 获取采集数据
- (NSDictionary *)collectGet;
@end
