//
//  DRHomeTableViewCell.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/19.
//  Copyright © 2019 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRTimeListModel;
@interface DRHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) DRTimeListModel *model;
@end

NS_ASSUME_NONNULL_END
