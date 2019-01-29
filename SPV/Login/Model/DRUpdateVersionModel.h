//
//  DRUpdateVersionModel.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/25.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRUpdateVersionModelObj;
@interface DRUpdateVersionModel : DRBaseModel
@property (nonatomic ,strong)DRUpdateVersionModelObj *obj;
@end

@interface DRUpdateVersionModelObj : NSObject
@property (nonatomic ,strong)NSString *versionCode;
@property (nonatomic ,strong)NSString *latestVersion;
@property (nonatomic ,assign )BOOL force;
@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *errorMsg;
@end
