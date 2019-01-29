//
//  LoginView.h
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRPhoneTextView.h"
#import "DRPwdTextView.h"
@protocol LoginViewDelegate <NSObject>
@optional

/**
 登录按钮回调

 @param isWithPhone 是否用手机登录
 */
- (void)loginViewLoginBtnClickWithPhone:(BOOL)isWithPhone;
- (void)loginViewRegisterBtnClick;
- (void)loginViewVerifyCodeBtnClick;
@end


@interface LoginView : UIView
@property (nonatomic ,weak)id <LoginViewDelegate>delegate;
@property (nonatomic ,strong) DRPhoneTextView *phoneView;
@property (nonatomic ,strong) DRPwdTextView *pwdView;


///用户名或密码错误，请重新输入
@property (nonatomic ,strong) UILabel *errorMsgLab;
+ (instancetype)loginView;
//- (void)textChange:(UITextField *)textField;
- (void)timeFailBeginFrom:(NSInteger) time;
@end
