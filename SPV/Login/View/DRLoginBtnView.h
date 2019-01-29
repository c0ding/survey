//
//  DRLoginBtnView.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/20.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRLoginBtnView : UIView

/**
 进度值
 */
@property (nonatomic,copy) NSString *progressValue;

/**
 进度条的颜色
 */
@property (nonatomic,strong) UIColor *progressColor;

/**
 进度条的背景色
 */
@property (nonatomic,strong) UIColor *bottomColor;

/**
 进度条的速度
 */
@property (nonatomic,assign) float time;

/**
 上层的文本
 */
@property (nonatomic,strong) UILabel *topLab;
@end
