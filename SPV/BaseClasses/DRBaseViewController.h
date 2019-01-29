//
//  DRBaseViewController.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/29.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRPlaceholderView.h"
@class DRUpdateVersionModel;
@interface DRBaseViewController : UIViewController<DRPlaceholderViewDelegate>
@property (nonatomic, assign) BOOL haveNONavi;
@property (nonatomic ,strong)LGAlertView *updateAlertView;
- (void)showBackBtnWithHiddelState:(BOOL )isHiddel;
- (void)hiddenPlaceholderView;
- (void)showPlaceholderViewWithImgName:(NSString *)imgName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnTitle:(NSString *)btnTitle;

/**
 版本更新
 */
- (void)updateWithDRUpdateVersionModel:(DRUpdateVersionModel*)model;
- (void)toUpdateWithDRUpdateVersionModel:(DRUpdateVersionModel*)model ;
@end
