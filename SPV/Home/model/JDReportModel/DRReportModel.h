//
//  DRReportModel.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRReportPicListModel;
NS_ASSUME_NONNULL_BEGIN

/**
 "locationAddr":"实地定位-详细地址",
 "longitude":1,
 "latitude":2.2,
 "desc":"项目描述",
 "resume":"案例情况简述",
 "result":"评估结果",
 "guaranteeId":1,
 "picList":[]
 **/



@interface DRReportModel : NSObject

@property (nonatomic, strong) NSString *locationAddr;

@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *resume;
@property (nonatomic, strong) NSString *result;

@property (nonatomic, assign) NSInteger guaranteeId;


@property (nonatomic, strong) NSMutableArray <DRReportPicListModel *> * picList;
@end


/**
 "url":"https://",
 "type":1,
 "desc":"照片描述"
 **/

@interface DRReportPicListModel : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
