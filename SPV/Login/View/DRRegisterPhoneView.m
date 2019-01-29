//
//  DRRegisterPhoneView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/14.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRRegisterPhoneView.h"
#import "DRVerifyCodeButton.h"
#import "DRLoginBtnView.h"
@interface DRRegisterPhoneView ()<UITextFieldDelegate,DRVerifyCodeBtnDelegate>
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) UIView *stepLine;
@property (nonatomic ,strong) UIView *phoneView;
@property (nonatomic ,strong) UIView *phoneLine;
@property (nonatomic ,strong) UIView *verifyCodeLine;
@property (nonatomic ,strong) DRVerifyCodeButton *verifyCodeBtn;// 获取验证码

@property (nonatomic ,strong) UIView *codeView;
@property (nonatomic ,strong) UIView *codeLine;

@property (nonatomic ,strong) DRLoginBtnView *nextBtnView;

@property (nonatomic ,strong) UIImageView *copyrightImageView;
@end
@implementation DRRegisterPhoneView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}
- (void)initUI {
    _stepLine = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorWithString:@"#E2E4EB"];
        view;
    });
    
    _lab1 =({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(34)];
        label.textColor = RGB(0, 0, 0);
        label.text = @"输入手机号";
        label;
    });
    
    _phoneView = ({
        UIView *view= [UIView new];
        [self addSubview:view];
        _phoneText = [UITextField new];
        _phoneText.textColor = RGB(80, 145, 255);
        [view addSubview:_phoneText];
        _phoneText.placeholder = @"手机号";
        _phoneText.delegate = self;
        [_phoneText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        _phoneText.returnKeyType = UIReturnKeyNext;
        _phoneText.keyboardType = UIKeyboardTypePhonePad; // 电话号码键盘
        _phoneText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
//        _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
//        UIButton *userClearButton = [_phoneText valueForKey:@"_clearButton"];
//        [userClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _phoneLine = [UIView new];
        [view addSubview:_phoneLine];
        _phoneLine.backgroundColor = RGB(220, 228, 240);
        
        _verifyCodeLine = [UIView new];
        [view addSubview:_verifyCodeLine];
        _verifyCodeLine.backgroundColor = RGB(220, 228, 240);
        
        _verifyCodeBtn = [[DRVerifyCodeButton alloc] init];
        [view addSubview:_verifyCodeBtn];
        _verifyCodeBtn.delegate = self;
        [_verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        view;
    });
    
    _errorMsgLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(12)];
        label.textColor = RGB(235, 103, 100);
        label.text = @"用户名或密码错误，请重新输入";
        label.hidden = YES;
        label;
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
        
        
        _codeText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _codeText.returnKeyType = UIReturnKeyDone;
        _codeText.keyboardType = UIKeyboardTypePhonePad; // 电话号码键盘
        _codeText.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
//        _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
//        UIButton *pwdClearButton = [_codeText valueForKey:@"_clearButton"];
//        [pwdClearButton setImage:kGetImage(@"login_deleteAll_btn_s") forState:UIControlStateNormal];
        _codeText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        [_codeText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        view;
    });
    
    _nextBtnView = ({
        DRLoginBtnView *view = [[DRLoginBtnView alloc] initWithFrame:CGRectMake(0, 0, kWidth(295), kHeight(50))];
        [self addSubview:view];
        view.bottomColor = RGB(215, 215, 215);
        view.progressValue = @"0";
        view.topLab.text = @"下一步";
        
        view.time = 0.2;
        view.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        WEAKSELF
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [weakSelf nextBtnclick:view];
        }];
        [view addGestureRecognizer:tap];
        view;
    });
    
    _copyrightImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"login_Copyright")];
        [self addSubview:imageView];
        imageView.hidden = NO;
        imageView;
    });
    
    [self textChange:self.phoneText];
}
- (void)setupFrame {
    
    [_stepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth*0.5);
        make.height.offset(2);
        make.top.equalTo(self.mas_top).offset(KIsiPhoneX?kHeight(28) :kHeight(22));
        make.left.equalTo(self.mas_left).offset(0);
    }];
    
   
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(96));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
    }];
    
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(75));
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
    
    [_verifyCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kHeight(20));
        make.width.offset(1);
        make.left.equalTo(_phoneText.mas_right).offset(1);
        make.centerY.equalTo(_phoneText.mas_centerY).offset(0);
    }];
    
    [_verifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(70));
        make.height.offset(kWidth(20));
        make.right.equalTo(_phoneView.mas_right).offset(0);
        make.centerY.offset(0);
    }];
    
    [_nextBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_errorMsgLab.mas_bottom).offset(kHeight(12));
        make.centerX.equalTo(_codeView.mas_centerX).offset(0);
        make.width.offset(kWidth(295));
        make.height.offset(kWidth(50));
    }];
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneView.mas_bottom).offset(kHeight(30));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(40));
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
    
    [_errorMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeView.mas_bottom).offset(kHeight(10));
        make.centerX.equalTo(_codeView.mas_centerX).offset(0);
    }];
    
    [_nextBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_errorMsgLab.mas_bottom).offset(kHeight(12));
        make.centerX.equalTo(_phoneView.mas_centerX).offset(0);
        make.width.offset(kWidth(295));
        make.height.offset(kWidth(50));
    }];
    
    [_copyrightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(40));
        make.bottom.offset(-kWidth(30));
    }];
}


#pragma mark - 验证码按钮事件
- (void)verifyCodeBtnClick {
    
    self.errorMsgLab.text = @"";
    if (![self.phoneText.text isPhoneNumber]) {
        self.errorMsgLab.text = @"请输入有效手机号";
        self.errorMsgLab.hidden = NO;
        return;
    }

    
    [self.verifyCodeBtn timeFailBeginFrom:kVerifyCodeBtnTimeFail]; // 倒计时60s
    
    if ([self.delegate respondsToSelector:@selector(verifyCodeBtnClick)]) {
        [self.delegate verifyCodeBtnClick];
    }
    
    // 调用短信验证码接口
    // 用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
    //    if （请求成功且匹配成功验证码数字）{
    //        [self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
    //    } else {
    //        [self.codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
    //    }
}
#pragma mark - 回车按钮事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _errorMsgLab.text = @"";
    if (_phoneText == textField) {
        [_codeText becomeFirstResponder];
    }else if (_codeText  == textField) {
        if (_codeText.text.length>0 &&_phoneText.text.length>0) {
            [self nextBtnclick:nil];
        }
    }
    return YES;
}
#pragma mark - 登录按钮事件
- (void)nextBtnclick:(UIView *)button {
    
    if ([self.delegate respondsToSelector:@selector(nextBtnClick)]) {
        _errorMsgLab.text = @"";
        [self.delegate nextBtnClick];
    }
}

- (void)timeFailBeginFrom:(NSInteger)time{
    [self.verifyCodeBtn timeFailBeginFrom:time];
}




///结束编辑
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

///开始编辑
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

///根据文本框内容的长度判断 登录按钮与验证按钮
- (void)textChange:(UITextField *)textField {
    _errorMsgLab.text = @"";
    
    BOOL loginBtnEnabled ;
    loginBtnEnabled = self.phoneText.text.length && self.codeText.text.length;
    self.nextBtnView.progressValue = loginBtnEnabled?@"1":@"0";
    self.nextBtnView.userInteractionEnabled = loginBtnEnabled;
    
    
    self.verifyCodeBtn.userInteractionEnabled = self.phoneText.text.length >10 && self.verifyCodeBtn.isCountdown==NO;
    if (textField == self.phoneText && self.verifyCodeBtn.isCountdown == NO) {
        self.phoneText.text.length >10?
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithString:@"#5092FF"] forState:UIControlStateNormal]:
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithString:@"#9B9B9B"] forState:UIControlStateNormal];
    }
    
}



@end
