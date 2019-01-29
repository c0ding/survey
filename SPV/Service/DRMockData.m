//
//  DRMockData.m
//  SPV
//
//  Created by 张逸阳 on 2018/7/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRMockData.h"

@implementation DRMockData
static DRMockData *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(instancetype)shareDRMockData {
    return [[self alloc]init];
}

-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

# pragma mark - mock
# pragma mark == 案件详情与状态
- (NSDictionary *)lawCaseMock{
    return  @{
              @"obj": @{
                      @"list" :@[
                              @{
                                  @"typeInfo":@"拍卖完成",
                                  @"isCurrentNode":@2,
                                  @"updateDay":@1530842382562,
                                  
                                  @"detailInfo" :@"共计7个抵押物，3个拍卖完成，4个拍卖中",
                                  @"stage":@"个字段加黑",
                                  },
                              
                              
                             
                              
                              @{
                                  @"typeInfo":@"拍卖中",
                                  @"isCurrentNode":@1,
                                  @"updateDay":@1530842382562,
                                  
                                  @"detailList" :@[
                                          @{@"remark":@"抵押物1：润进入润大厦进入润大A厦A进入润大厦A进入润大厦A进入润大厦A座室于进入润润大厦座1602室于2018/06/26进入润",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"抵押物2：2润大厦A座1602室于2018/06/26进入润大厦A座1602室于2018/06/26进入",
                                                @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"抵押物3：3润大厦A座1602室于2018/06/26进入润大厦A座1602室于2018/06/26进入",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"抵押物14:4润大厦A座1602室于2018/06/26进入润大厦A座1602室于2018/06/26进入",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"5润大厦A座1602润大厦A座1602",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"4润大厦A座1602室于2018/06/26进入润大厦A座1602室于2018/06/26进入",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"后动画很多很多很多很：多很多很多很多很多很多很多很多很多很多很多好点的好好的:很多很多很多很多的好的好好的很多很多很多很多很多很：多很多很多很多很多后动画打电话都会好的很多很多订货会的后代很多很多很多很多",
                                            @"caseStatus":@"二拍成功加黑"
                                            },
                                          
                                          @{@"remark":@"4进入",
                                            @"caseStatus":@"二黑"
                                            },
                                          
                                          @{@"remark":@"4润大厦A座1602室于2018/06/26进入润大厦A座1602室于2018/06/26进入",
                                            @"caseStatus":@"二拍成功加黑"
                                            }
                                          ]
                                  },
                              
                              
                              @{
                                  @"updateDay":@1530842382562,
                                  @"typeInfo":@"起诉2",
                                  @"isCurrentNode":@0,
                                  
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  },
                              @{
                                  @"typeInfo":@"起诉1",
                                  @"isCurrentNode":@0,
                                  }
                              
                              
                              ]
                      },
              @"msg": @"OK",
              @"code": @"200"
              };
    
    
}

# pragma mark == 抵押物详情
- (NSDictionary *)dywMock {
    return @{
             @"obj":@{
                     @"type":@1,
                     @"location":@"宁波市鄞州区石矸镇东杨村宁波市鄞州区石矸镇东杨村",
                     @"assetList":@[
                             @{
                                 @"name":@"抵押物估值",
                                 @"value":@"12,31.23万元",
                                 @"type":@0
                                 },
//                             @{
//                                 @"name":@"抵间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，押物估值",
//                                 @"value":@"12,31.23万元",
//                                 @"type":@0
//                                 },
//                             @{
//                                 @"name":@"抵押物估值",
//                                 @"value":@"12,31.23万元",
//                                 @"type":@0
//                                 },
//                             @{
//                                 @"name":@"厂房使用状态",
//                                 @"value":@"部分行未获业原车间划分出租，银行行未获业原车间划分出租，银行行未获业原车间划分出租，银行车，间划分。",
//                                 @"type":@1
//                                 },
//                             @{
//                                 @"name":@"厂房使用状态",
//                                 @"value":@"部分行未获业原车间划分出租，银行行未获间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，业原车间划分出租，银行行未获业原车间划分出租，银行车，间划分。",
//                                 @"type":@1
//                                 },
//                             @{
//                                 @"name":@"厂房使用状态",
//                                 @"value":@"部分行未获业原车间划分出租，银行行未获业原车间划分出租，银行行未获业原车间划分出租，银行车，间划分。",
//                                 @"type":@1
//                                 },
//
//
//                             @{
//                                 @"name":@"土地抵押状况",
//                                 @"value":@"-，具体承行未获业原车间划分出，银间划分出，间划分出，间划分出，间划分出，间划分出，间划分出，行未获得相关租赁合同，具体承",
//                                 @"type":@2
//                                 },
//                             @{
//                                 @"name":@"土地抵押状况",
//                                 @"value":@"-，具体承行未获业原车间划分出，银行未获得相关租赁合同，具体承",
//                                 @"type":@2
//                                 },
//                             @{
//                                 @"name":@"土地抵押状况",
//                                 @"value":@"-，具体承行未获业原车间划分出，间划分出，间划分出，间划分出，间划分出，银行未获得相关租赁合同，具体承",
//                                 @"type":@2
//                                 }
                             ],
                     @"nodeList":@[
//                             @{
//                                 @"isCurrentNode":@2,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成0"
//                                 },
//                             @{
//                                 @"isCurrentNode":@2,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成1"
//                                 },
//                             @{
//                                 @"isCurrentNode":@1,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成2"
//                                 },
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成3"
//                                 },
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成4"
//                                 },
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成5"
//                                 }
//                             ,
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成6"
//                                 },
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成4"
//                                 },
//                             @{
//                                 @"isCurrentNode":@0,
//                                 @"updateDay":@12332123112,
//                                 @"typeInfo":@"拍卖完成5"
//                                 }
//                             ,
                             @{
                                 @"isCurrentNode":@0,
                                 @"updateDay":@12332123112,
                                 @"typeInfo":@"拍卖完成6"
                                 }
                             ],
                     
                     @"mortagePredictPriceyList" : @[
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
                             @16602364.00,
//                             @16602364.00,
//                             @16602364.00,
//                             @16602364.00,
//                             @16602364.00,
                             
                             @16602364.00,
                             

                         ],
                     @"xList": @[
                             @"2018-02-11",
                             @"2018-02-12",
                             @"2018-02-13",
                             @"2018-02-14",
                             @"2018-02-15",
                             @"2018-02-16",
                             @"2018-02-17",
                             @"2018-02-18",
                             @"2018-02-19",
                             @"2018-02-20",
                             
                             @"2018-02-21",
                             @"2018-02-22",
                             @"2018-02-23",
                             @"2018-02-24",
                             @"2018-02-25",
//                             @"2018-02-26",
//                             @"2018-02-27",
//                             @"2018-02-28",
//                             @"2018-03-01",
                             
                             @"2018-03-02"
                             ],
                     @"yList":@[
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @6602364.00,
                                
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
                                @26602364.00,
//                                @26602364.00,
//                                @26602364.00,
//                                @26602364.00,
//                                @26602364.00,

                                @602364.00,
                             ]
                 
                 },
             @"msg":@"OK",
             @"code":@"200"
             };
}


#pragma mark == 版本更新
- (NSDictionary *)updateVersionMock {
    return @{
             @"obj":@{
                     @"versionCode":@"1.2.3",
                     @"force":@NO,
                     @"content":@"[新增] 登录支持用户名密码登录\n[新增] 支持查看案件进度，案件节点一目了然\n[优化] 一些细节优化，体验升级[新增] 登录支持用户名密码登录\n[新增] 支持查看案件进度，案件节点一目了然\n[优化] 一些细节优化，体验升级",
                     @"title":@"提示"
                     },
             @"code":@200
             
             };
}
#pragma mark == 债权主页
- (NSDictionary *)obligatoryRightsMock {
    return @{
             @"assetList":@[
                     @{
                         @"amapLongitude":@121.231430,
                         @"amapLatitude":@28.129615,
                         @"typeDetailedName":@"商铺",
                         @"title":@"玉环县玉城街道泰安路56号",
                         @"pawnid":@"",
                         @"disposeStatus":@0
                         }
                     ]
             
             };
}
@end
