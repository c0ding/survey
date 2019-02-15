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
                                          
                                          
                                          ]
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

#pragma mark == 获取采集数据
- (NSDictionary *)collectGet{
    
//    字段类型(1-字符 2-数字 3-面积 4-年份 5-日期 6-下拉框 7-是否型单选 8-附件)
    return @{
             @"errorMsg":@"OK",
             @"code":@"200",
             @"data":@{
                     @"type":@"抵押物类型",
                     @"dataList":@[
                             @{
                                 @"name":@"左边名字",
                                 @"param":@"param回传使用",
                                 @"type":@2,
                                 @"content":@"s右边内容",
                                 @"needTransform":@1,
                                 @"select":@[],
                                 @"attachmentList":@[
                                         @{
                                             @"name":@"",
                                             @"url":@"",
                                             },
                                         ],
                                 
                                 },
                             ],
                     @"longitude":@123.1231231,
                     @"latitude":@123.56565,
                     @"locationAddr":@"实地定位-详细地址",
                     @"locationSurrounding":@"实地定位-周边配套",
                     @"picList":@[
                             @{
                                 @"id":@"123456",
                                 @"type":@"1-照片 2-视频",
                                 @"url":@"图片地址",
                                 @"desc":@"图片描述",
                                 },
                             ],
                     @"picRemark":@"实地拍摄-备注信息",
                     @"systemTime":@"系统时间å",
                     
                     
                     }
             };
}
@end
