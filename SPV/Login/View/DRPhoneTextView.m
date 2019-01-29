
//
//  DRPhoneTextView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/22.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRPhoneTextView.h"
#define MAX_STARWORDS_LENGTH 6
@interface DRPhoneTextView ()<UITextFieldDelegate,DRVerifyCodeBtnDelegate>
@end

@implementation DRPhoneTextView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
        [self textChange:self.phoneText];
    }
    return self;
}

- (void)initUI {
    _phoneView = ({
        UIView *usernameView= [UIView new];
        [self addSubview:usernameView];
        _phoneText = [UITextField new];
        _phoneText.textColor = RGB(80, 145, 255);
        [usernameView addSubview:_phoneText];
        _phoneText.placeholder = @"手机号";
        _phoneText.delegate = self;
        _phoneText.keyboardType = UIKeyboardTypePhonePad; // 电话号码键盘
        [_phoneText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        _phoneText.returnKeyType = UIReturnKeyNext;
        _phoneText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIButton *userClearButton = [_phoneText valueForKey:@"_clearButton"];
        [userClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _phoneLine = [UIView new];
        [usernameView addSubview:_phoneLine];
        _phoneLine.backgroundColor = RGB(220, 228, 240);
        
        _verifyCodeLine = [UIView new];
        [usernameView addSubview:_verifyCodeLine];
        _verifyCodeLine.backgroundColor = RGB(220, 228, 240);
        
        _verifyCodeBtn = [[DRVerifyCodeButton alloc] init];
        [usernameView addSubview:_verifyCodeBtn];
        _verifyCodeBtn.delegate = self;
        [_verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        usernameView;
    });
    
    _codeView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        _codeLine = [UIView new];
        [view addSubview:_codeLine];
        _codeLine.backgroundColor = RGB(220, 228, 240);
        _codeText = [UITextField new];
        [view addSubview:_codeText];
        _codeText.delegate = self;
        _codeText.textColor = RGB(80, 145, 255);
        _codeText.placeholder = @"验证码";
        _codeText.keyboardType = UIKeyboardTypePhonePad; // 电话号码键盘
        
        //        _pwdText.secureTextEntry = YES;
        _codeText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _codeText.returnKeyType = UIReturnKeyDone;
        _codeText.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIButton *pwdClearButton = [_codeText valueForKey:@"_clearButton"];
        [pwdClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _codeText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        [_codeText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        view;
    });
}
- (void)setupFrame {
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(5));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(40));
    }];
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneView.mas_bottom).offset(kHeight(30));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(40));
    }];
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneView.mas_left).offset(1);
        make.centerY.equalTo(_phoneView.mas_centerY).offset(0);
        make.width.offset(kWidth(205));
        //        make.right.equalTo(self.usernameView.mas_right).offset(0);
        make.height.offset(kHeight(31));
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneView.mas_left).offset(0);
        make.right.equalTo(_phoneView.mas_right).offset(0);
        make.bottom.equalTo(_phoneView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_verifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(70));
        make.height.offset(kWidth(20));
        make.right.equalTo(_phoneView.mas_right).offset(0);
        make.centerY.offset(0);
    }];
    
    [_verifyCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kHeight(20));
        make.width.offset(1);
        make.left.equalTo(_phoneText.mas_right).offset(1);
        make.centerY.equalTo(_phoneText.mas_centerY).offset(0);
    }];
    
    [_codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.mas_left).offset(0);
        make.right.equalTo(_codeView.mas_right).offset(0);
        make.bottom.equalTo(_codeView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.mas_left).offset(1);
        make.centerY.equalTo(_codeView.mas_centerY).offset(0);
        make.right.equalTo(_codeView.mas_right).offset(0);
        make.height.offset(kHeight(31));
    }];
    
}

- (void)DRVerifyCodeBtnTimeStart:(DRVerifyCodeButton *)btn timeCount:(NSInteger)count {
    [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"%lds后重发", count] forState:UIControlStateNormal];
    [self.verifyCodeBtn setTitleColor:[UIColor colorWithString:@"#9B9B9B"] forState:UIControlStateNormal];
    self.verifyCodeBtn.userInteractionEnabled = NO;
}

- (void)DRVerifyCodeBtnTimeEnd:(DRVerifyCodeButton *)btn {
    [self.verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verifyCodeBtn.userInteractionEnabled = YES;
//    [self textChange:self.phoneText];
}

#pragma mark - 验证码按钮事件
- (void)verifyCodeBtnClick {
    if ([self.delegate respondsToSelector:@selector(verifyCodeBtnClick)]) {
        [self.delegate verifyCodeBtnClick];
    }
}

///结束编辑，做出下划线、字体的样式改变
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField) {
        if (_phoneText.text.length<1) {
            [UIView animateWithDuration:0.1 animations:^{
                _phoneLine.backgroundColor = RGB(220 , 228, 240);
            }];
        }
    }
    
    if (_codeText.text.length<1) {
        [UIView animateWithDuration:0.1 animations:^{
            _codeLine.backgroundColor = RGB(220 , 228, 240);
            
        }];
    }
    _phoneText.textColor = RGB(74, 74, 74);
    _codeText.textColor = RGB(74, 74, 74);
}

///开始编辑，做出下划线、字体的样式改变
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _phoneText) {
        [UIView animateWithDuration:0.5 animations:^{
            _phoneText.textColor = RGB(80, 146, 255);
            _phoneLine.backgroundColor = RGB(80, 146, 255);
            
        }];
    }
    
    if (textField == _codeText) {
        [UIView animateWithDuration:0.5 animations:^{
            _codeText.textColor = RGB(80, 146, 255);
            _codeLine.backgroundColor = RGB(80, 146, 255);
        }];
    }
}

///根据文本框内容的长度判断 登录按钮与验证按钮
- (void)textChange:(UITextField *)textField {
    self.verifyCodeBtn.userInteractionEnabled = _phoneText.text.length>10 && self.verifyCodeBtn.isCountdown==NO;

    if (textField == _phoneText && self.verifyCodeBtn.isCountdown == NO) {
        _phoneText.text.length >10?
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithString:@"#5092FF"] forState:UIControlStateNormal]:
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithString:@"#9B9B9B"] forState:UIControlStateNormal];
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(phoneTextChange:)]) {
        [self.delegate phoneTextChange:textField];
    }
    
}


@end
