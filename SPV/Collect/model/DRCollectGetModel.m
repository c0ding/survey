//
//  DRCollectGetModel.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/15.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectGetModel.h"


@implementation DRCollectGetModel

@end

@implementation DRCollectGetData
+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"dataList":[DataModel class],
             @"picList":[PicModel class]
             };
}
@end

@implementation DataModel
+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"attachmentList":[AttachmentModel class],
             @"select":[SelectModel class]
             };
}


@end


@implementation SelectModel
@end

@implementation AttachmentModel

@end
@implementation PicModel

@end
