//
//  DRUpdateVersionView.h
//  SPV
//
//  Created by 张逸阳 on 2018/7/24.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRUpdateVersionView : UIView
typedef void(^UpdateBtnClickBlcok) (id sender);
typedef void(^CancelBtnClickBlcok) (id sender);
- (instancetype)initWithFrame:(CGRect)frame andDRUpdateVersionModel :(DRUpdateVersionModel *)model;


@property (nonatomic,copy)UpdateBtnClickBlcok updateBtnClickBlcok;
@property (nonatomic,copy)CancelBtnClickBlcok cancelBtnClickBlcok;
@property (nonatomic ,assign)BOOL isContainsCancelBtn;

@property (nonatomic ,strong) UILabel *tagLab;
@property (nonatomic ,strong) UILabel *tittleLab;
@property (nonatomic ,strong) UILabel *contentLab;

@end
