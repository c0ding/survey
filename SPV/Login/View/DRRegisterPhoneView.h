//
//  DRRegisterPhoneView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/14.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRRegisterPhoneViewDelegate <NSObject>
@optional
- (void)nextBtnClick;
- (void)verifyCodeBtnClick;
@end


@interface DRRegisterPhoneView : UIView
@property (nonatomic ,strong) UITextField *phoneText;
@property (nonatomic ,strong) UITextField *codeText;
///用户名或密码错误，请重新输入
@property (nonatomic ,strong) UILabel *errorMsgLab;
@property (nonatomic ,weak)id <DRRegisterPhoneViewDelegate>delegate;
///检查文本
- (void)textChange:(UITextField *)textField ;
///倒计时复位
- (void)timeFailBeginFrom:(NSInteger) time;
@end
