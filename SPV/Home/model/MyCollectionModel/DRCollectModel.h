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

@property (nonatomic, strong) NSString *obligatoryRightName;
@property (nonatomic, strong) NSString *obligatoryRightId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSMutableArray<DRCollectListModel*> *list;


@end

/**
 @"time":@"2018/5/25",
 @"obligatoryRightName":@"浙江岱山县岱西仇家门",
 @"projectType":@1,
 @"type":@"工业",
 @"ifCollect":@1
 **/
@interface DRCollectListModel : NSObject
@property (nonatomic, strong) NSString *guaranteeId;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *timeStatus;
@property (nonatomic, strong) NSString *guaranteeName;
@property (nonatomic, assign) NSInteger inspectStatus;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger attention;



@end

NS_ASSUME_NONNULL_END
