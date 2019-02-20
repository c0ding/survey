//
//  DRJDHomeModel.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/13.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRTimeListModel,DRAssignmentListModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRJDHomeModel : NSObject

@property (nonatomic, strong) NSMutableArray<DRAssignmentListModel*> *data;


@end

@interface DRAssignmentListModel : NSObject

@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong) NSMutableArray<DRTimeListModel*> *list;

@end




@interface DRTimeListModel : NSObject
@property (nonatomic, strong)NSString *assignId;

@property (nonatomic, strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
