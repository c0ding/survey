//
//  DRScrollView.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/12.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRScrollView : UIScrollView
/** 内部维护的内容视图(用来支持自动布局) */
@property (nonatomic, strong) UIView *contentView;

@end
