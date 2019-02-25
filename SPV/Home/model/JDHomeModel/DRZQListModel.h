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

@interface DRZQListModel : NSObject

@property (nonatomic, strong) NSString *assetPackageName;
@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) NSMutableArray<DRZQListDetailModel*> *list;

@end

/**
 
 numerator    分子-尽调进度
 denominator    分母-尽调进度
 obligatoryRightName    债权名
 obligatoryRightId    债权id
 **/

@interface DRZQListDetailModel : NSObject
@property (nonatomic, strong) NSString *obligatoryRightId;
@property (nonatomic ,strong) NSString *obligatoryRightName;
@property (nonatomic, assign) CGFloat denominator;
@property (nonatomic, assign) CGFloat numerator;

@end
NS_ASSUME_NONNULL_END
