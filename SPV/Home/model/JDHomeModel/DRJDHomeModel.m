//
//  DRJDHomeModel.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/13.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRJDHomeModel.h"

@implementation DRJDHomeModel


+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"assignmentList":[DRAssignmentListModel class]
             };
}

@end



@implementation DRAssignmentListModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"timeList":[DRTimeListModel class]
             };
}

@end

@implementation DRTimeListModel


@end
