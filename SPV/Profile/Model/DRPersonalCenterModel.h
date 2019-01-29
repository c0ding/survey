//
//  DRPersonalCenterModel.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/21.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRBaseModel.h"


@class DRPersonalCenterModelObj;
@interface DRPersonalCenterModel : DRBaseModel

@property (nonatomic ,strong) DRPersonalCenterModelObj *obj;
+(instancetype)shareDRPersonalCenterModel;

@end


@interface DRPersonalCenterModelObj : DRBaseModel

@property (nonatomic ,strong) NSString *userFeedback;
@property (nonatomic ,strong) NSString *aboutus;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *nickname;
@property (nonatomic ,strong) NSString *company;
@property (nonatomic ,strong) NSString *disclaimer;
@property (nonatomic ,strong) NSString *email;

@end

