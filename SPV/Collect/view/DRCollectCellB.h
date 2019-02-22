//
//  DRCollectCellB.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/21.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define topMargin 16
#define bottomMargin 16
#define labFont 15
#define labW 270
@interface DRCollectCellB : UITableViewCell
@property (nonatomic ,strong) NSString *leftTittle;
@property (nonatomic ,strong) NSString *rightTittle;

@property (nonatomic ,strong) NSString *danweiTittle;
@end

NS_ASSUME_NONNULL_END
