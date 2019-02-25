//
//  DRReportLeftTableViewCell.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRCollectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRReportLeftTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger selectTag;
@property (nonatomic, strong) DRCollectListModel *model;
@end

NS_ASSUME_NONNULL_END
