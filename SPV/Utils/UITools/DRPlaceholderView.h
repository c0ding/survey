//
//  DRPlaceholderView.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/29.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRPlaceholderView;

@protocol DRPlaceholderViewDelegate <NSObject>

/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(DRPlaceholderView *)placeholderView
   reloadButtonDidClick:(UIButton *)sender;

/** 占位图的返回按钮点击时回调 */
- (void)placeholderView:(DRPlaceholderView *)placeholderView
   backButtonDidClick:(UIButton *)sender;

@end

@interface DRPlaceholderView : UIView
@property (nonatomic, weak) id <DRPlaceholderViewDelegate> delegate;
///返回按钮
@property (nonatomic ,strong)UIButton *backBtn;
- (void)setupValueWithImgName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnTitle:(NSString *)btnTitle;
@end
