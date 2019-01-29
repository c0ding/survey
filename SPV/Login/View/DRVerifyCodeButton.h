//
//  DRVerifyCodeButton.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRVerifyCodeButton;
@protocol DRVerifyCodeBtnDelegate <NSObject>
@optional

/// 按钮倒计时开始
- (void)DRVerifyCodeBtnTimeStart:(DRVerifyCodeButton *)btn timeCount:(NSInteger)count;

/// 按钮倒计时结束
- (void)DRVerifyCodeBtnTimeEnd:(DRVerifyCodeButton *)btn;


@end

@interface DRVerifyCodeButton : UIButton
@property (nonatomic ,weak)id <DRVerifyCodeBtnDelegate>delegate;
///倒计时中,颜色不可变化
@property (nonatomic, assign) BOOL isCountdown;

- (void)timeFailBeginFrom:(NSInteger)timeCount;

@end
