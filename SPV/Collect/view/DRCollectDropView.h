//
//  DRCollectDropView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCollectDropView : UIView
- (void)showSelect:(BOOL)isSelect ;
@property (nonatomic ,copy)NSString *text;
@end

NS_ASSUME_NONNULL_END
