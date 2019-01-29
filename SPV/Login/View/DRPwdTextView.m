//
//  DRPwdTextView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/22.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRPwdTextView.h"
@interface DRPwdTextView()<UITextFieldDelegate>

@end

@implementation DRPwdTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
        [self textChange];
    }
    return self;
}

- (void)initUI {
    _usernameView = ({
        UIView *usernameView= [UIView new];
        [self addSubview:usernameView];
        _userText = [UITextField new];
        _userText.textColor = RGB(80, 145, 255);
        [usernameView addSubview:_userText];
        _userText.placeholder = @"用户名";
        _userText.delegate = self;
        _userText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_userText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
        _userText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        _userText.returnKeyType = UIReturnKeyNext;
        _userText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        UIButton *userClearButton = [_userText valueForKey:@"_clearButton"];
        [userClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _userLine = [UIView new];
        [usernameView addSubview:_userLine];
        _userLine.backgroundColor = RGB(220, 228, 240);
        
        usernameView;
    });
    
    _passwordView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        _pwdLine = [UIView new];
        [view addSubview:_pwdLine];
        _pwdLine.backgroundColor = RGB(220, 228, 240);
        _pwdText = [UITextField new];
        [view addSubview:_pwdText];
        _pwdText.delegate = self;
        _pwdText.textColor = RGB(80, 145, 255);
        _pwdText.placeholder = @"密码";
        _pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdText.secureTextEntry = YES;
        _pwdText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _pwdText.returnKeyType = UIReturnKeyDone;
        _pwdText.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        UIButton *pwdClearButton = [_pwdText valueForKey:@"_clearButton"];
        [pwdClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _pwdText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        [_pwdText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
        view;
    });
}

- (void)setupFrame {
    
    [_usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(5));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(40));
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameView.mas_bottom).offset(kHeight(30));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(40));
    }];
    
    
    [_userText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameView.mas_left).offset(1);
        make.centerY.equalTo(self.usernameView.mas_centerY).offset(0);
        make.right.equalTo(self.usernameView.mas_right).offset(0);
        make.height.offset(kHeight(31));
    }];
    
    [_userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameView.mas_left).offset(0);
        make.right.equalTo(self.usernameView.mas_right).offset(0);
        make.bottom.equalTo(self.usernameView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordView.mas_left).offset(0);
        make.right.equalTo(self.passwordView.mas_right).offset(0);
        make.bottom.equalTo(self.passwordView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordView.mas_left).offset(1);
        make.centerY.equalTo(self.passwordView.mas_centerY).offset(0);
        make.right.equalTo(self.passwordView.mas_right).offset(0);
        make.height.offset(kHeight(31));
    }];
}


///结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField) {
        
        if (_userText.text.length<1) {
            [UIView animateWithDuration:0.1 animations:^{
                _userLine.backgroundColor = RGB(220 , 228, 240);
            }];
        }
    }
    
    if (_pwdText.text.length<1) {
        [UIView animateWithDuration:0.1 animations:^{
            _pwdLine.backgroundColor = RGB(220 , 228, 240);
            
        }];
    }
    
    _userText.textColor = RGB(74, 74, 74);
    _pwdText.textColor = RGB(74, 74, 74);
}

///开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _userText) {
        [UIView animateWithDuration:0.5 animations:^{
            _userText.textColor = RGB(80, 146, 255);
            _userLine.backgroundColor = RGB(80, 146, 255);
            
        }];
    }
    
    if (textField == _pwdText) {
        [UIView animateWithDuration:0.5 animations:^{
            _pwdText.textColor = RGB(80, 146, 255);
            _pwdLine.backgroundColor = RGB(80, 146, 255);
        }];
    }
    
}


- (void)textChange {
    BOOL loginBtnEnabled ;
    loginBtnEnabled = self.userText.text.length && self.pwdText.text.length>=6;
    if ([self.delegate respondsToSelector:@selector(pwdTextChangeWithValue:)]) {
        [self.delegate pwdTextChangeWithValue:loginBtnEnabled];
    }
    
}

@end
