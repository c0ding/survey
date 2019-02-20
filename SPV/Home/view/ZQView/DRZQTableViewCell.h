//
//  DRZQTableViewCell.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/19.
//  Copyright © 2019 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRZQListDetailModel;
@interface DRZQTableViewCell : UITableViewCell

@property (nonatomic, strong) DRZQListDetailModel *model;

@end

NS_ASSUME_NONNULL_END
