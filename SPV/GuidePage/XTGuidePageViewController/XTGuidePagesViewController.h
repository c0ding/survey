//
//  XTGuidePagesViewController.h
//  XTGuidePagesView
//
//  Created by zjwang on 16/5/30.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+Transition.h"
#import "DRBaseViewController.h"
@protocol selectDelegate <NSObject>

- (void)clickEnter;

@end
@interface XTGuidePagesViewController : DRBaseViewController

@property (nonatomic, strong) UIButton *btnEnter;
// 初始化引导页
- (void)guidePageControllerWithImages:(NSArray *)images;
+ (BOOL)isShow;
@property (nonatomic, assign) id<selectDelegate> delegate;
//+ (instancetype)shareXTGuideVC;
@end
