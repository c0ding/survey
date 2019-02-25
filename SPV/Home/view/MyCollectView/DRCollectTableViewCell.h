//
//  DRCollectTableViewCell.h
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRCollectListModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRCollectTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL collectVC;

@property (nonatomic, strong) DRCollectListModel *model;

@end

NS_ASSUME_NONNULL_END
