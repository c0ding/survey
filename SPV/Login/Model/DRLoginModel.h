//
//  DRLoginModel.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/21.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRBaseModel.h"

@class DRLoginModelObj;
@interface DRLoginModel : DRBaseModel
@property (nonatomic ,strong)DRLoginModel *obj;
@end

@interface DRLoginModelObj :NSObject
@property (nonatomic ,strong)NSString *userName;
@property (nonatomic ,strong)NSString *nickName;
@property (nonatomic ,strong)NSString *userKey;
@end
