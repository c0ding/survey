//
//  DRPhoneTextView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/22.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRVerifyCodeButton.h"
#import "DRLoginBtnView.h"
@protocol DRPhoneTextViewDelegate <NSObject>
@optional
- (void)verifyCodeBtnClick;
- (void)phoneTextChange:(UITextField *)textField;
@end

@interface DRPhoneTextView : UIView
@property (nonatomic ,weak)id <DRPhoneTextViewDelegate>delegate;
@property (nonatomic ,strong) UITextField *phoneText;
@property (nonatomic ,strong) UITextField *codeText;
@property (nonatomic ,strong) UIView *phoneView;
@property (nonatomic ,strong) UIView *phoneLine;
@property (nonatomic ,strong) UIView *verifyCodeLine;
@property (nonatomic ,strong) UIView *codeView;
@property (nonatomic ,strong) UIView *codeLine;
@property (nonatomic ,strong) DRVerifyCodeButton *verifyCodeBtn;
- (void)textChange:(UITextField *)textField;
@end
