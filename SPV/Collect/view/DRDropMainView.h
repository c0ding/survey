//
//  DRDropMainView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kRowH 53
#define kRowCount 3
@interface DRDropMainView : UIView
@property (nonatomic ,assign)NSInteger currertSelect;

typedef void(^DropMainBlock)(NSInteger index, NSString* text);
@property (nonatomic ,copy)DropMainBlock dropMainBlock;
@end

NS_ASSUME_NONNULL_END
