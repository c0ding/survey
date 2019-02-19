//
//  DRZQListModel.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRZQListDetailModel;
NS_ASSUME_NONNULL_BEGIN
/**
 @"name":@"浙江岱山县岱西仇家门",
 @"amoutCount":@5,
 @"currentCount":@1,
 **/
@interface DRZQListModel : NSObject


@property (nonatomic, strong) NSMutableArray<DRZQListDetailModel*> *ZQList;

@end



@interface DRZQListDetailModel : NSObject
@property (nonatomic ,strong) NSString *name;
@property (nonatomic, assign) NSInteger amoutCount;
@property (nonatomic, assign) NSInteger currentCount;

@end
NS_ASSUME_NONNULL_END
