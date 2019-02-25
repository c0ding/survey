//
//  DRReportViewController.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRBaseViewController.h"
#import "DRCollectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRReportViewController : DRBaseViewController

@property (nonatomic, strong) NSString *obligatoryRightId;

@property (nonatomic, strong) DRCollectModel *modelCollect;

@end

NS_ASSUME_NONNULL_END
