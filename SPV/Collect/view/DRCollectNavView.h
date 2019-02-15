//
//  DRCollectNavView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCollectNavView : UIView
typedef void(^BtnClickBlock)();
@property (nonatomic ,copy)BtnClickBlock leftClickBlock;
@property (nonatomic ,copy)BtnClickBlock rightClickBlock;
@property (nonatomic ,copy)BtnClickBlock centerClickBlock;

- (void)showBtn:(BOOL)isShow;
@property (nonatomic ,copy)NSString *text;
@end

NS_ASSUME_NONNULL_END
