//
//  DRCollectModel.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DRCollectListModel;
@interface DRCollectModel : NSObject

@property (nonatomic, strong) NSMutableArray<DRCollectListModel*> *collectList;


@end

/**
 @"time":@"2018/5/25",
 @"name":@"浙江岱山县岱西仇家门",
 @"projectType":@1,
 @"type":@"工业",
 @"ifCollect":@1
 **/
@interface DRCollectListModel : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger projectType;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger ifCollect;


@end

NS_ASSUME_NONNULL_END
