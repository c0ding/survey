//
//  DRCollectCellLeftView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/15.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define topMargin 16
#define bottomMargin 16
#define labFont 15
#define labW 270
@interface DRCollectCellA : UITableViewCell
@property (nonatomic ,strong) NSString *leftTittle;
@property (nonatomic ,strong) NSString *rightTittle;

@end

NS_ASSUME_NONNULL_END
