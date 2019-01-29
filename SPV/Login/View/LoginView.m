///
//  LoginView.m
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "LoginView.h"
#import "DRLoginBtnView.h"
#import "DRVerifyCodeButton.h"
@interface LoginView()
<UITextFieldDelegate,DRVerifyCodeBtnDelegate,DRPhoneTextViewDelegate,DRPwdTextViewDelegate>
///摩安资产
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) UILabel *lab2;
@property (nonatomic ,strong) DRLoginBtnView *loginBtnView;
///Copyright ©️ 2018 Mo
@property (nonatomic ,strong) UIImageView *copyrightImageView;
///邀请码注册
@property (nonatomic ,strong) UIButton *registerBtn;
/// 切换按钮
@property (nonatomic ,strong) UIButton *switchBtn;

@end

#define  kSwitchBtnTextPhone @" 手机验证登录"
#define  kSwitchBtnTextUsername @" 账号密码登录"
@implementation LoginView

#pragma mark - 验证码按钮事件
- (void)verifyCodeBtnClick {
    _errorMsgLab.text = @"";
    self.errorMsgLab.hidden = YES;
    if (![self.phoneView.phoneText.text isPhoneNumber]) {
        self.errorMsgLab.text = @"请输入有效手机号";
        self.errorMsgLab.hidden = NO;
        return;
    }
    [self.phoneView.verifyCodeBtn timeFailBeginFrom:kVerifyCodeBtnTimeFail]; // 倒计时60s
    if ([self.delegate respondsToSelector:@selector(loginViewVerifyCodeBtnClick)]) {
        [self.delegate loginViewVerifyCodeBtnClick];
    }

}

- (void)timeFailBeginFrom:(NSInteger)time{
    [self.phoneView.verifyCodeBtn timeFailBeginFrom:time];
}

#pragma mark - 注册按钮事件
- (void)registerBtnClick {
    _errorMsgLab.text = @"";
    if ([self.delegate respondsToSelector:@selector(loginViewRegisterBtnClick)]) {
        [self.delegate loginViewRegisterBtnClick];
    }
}

#pragma mark - 回车按钮事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (_userText == textField) {
//        [_pwdText becomeFirstResponder];
//    }else if (_pwdText  == textField) {
//        if (_pwdText.text.length>0 &&_userText.text.length>0) {
//            [self loginBtnclick:nil];
//        }
//    }
    return YES;
}
#pragma mark - 登录按钮事件
- (void)loginBtnclick:(UIView *)button {
    _errorMsgLab.text = @"";
    //是否用手机号登录
    BOOL isWithPhoneLogin = [self.switchBtn.titleLabel.text isEqualToString: kSwitchBtnTextPhone]?NO:YES;
    
    
    if (![self.phoneView.phoneText.text isPhoneNumber] && isWithPhoneLogin) {
        self.errorMsgLab.text = @"请输入有效手机号";
        self.errorMsgLab.hidden = NO;
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(loginViewLoginBtnClickWithPhone:)]) {
        [self.delegate loginViewLoginBtnClickWithPhone:isWithPhoneLogin];
    }
}

#pragma mark - 限制长度
- (void)textMaxLength:(UITextField *)textField andLength:(NSInteger)length{
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > length)
            {
                textField.text = [toBeString substringToIndex:length];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > length)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:length];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:length];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, length)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - 手机 验证码，登录页 文本改变回调
- (void)phoneTextChange:(UITextField *)textField {
    _errorMsgLab.text = @"";
    
    if (textField == self.phoneView.codeText) {
        [self textMaxLength:textField andLength:6];
    }
    
    
    BOOL loginBtnEnabled ;
    loginBtnEnabled = self.phoneView.phoneText.text.length && self.phoneView.codeText.text.length==6;
    self.loginBtnView.progressValue = loginBtnEnabled?@"1":@"0";
    self.loginBtnView.userInteractionEnabled = loginBtnEnabled;
}
#pragma mark - 用户登录页 文本改变回调
- (void)pwdTextChangeWithValue:(BOOL)isShow {
    _errorMsgLab.text = @"";
    
    [self textMaxLength:self.pwdView.pwdText  andLength:20];
    
    
    self.loginBtnView.progressValue = isShow?@"1":@"0";
    self.loginBtnView.userInteractionEnabled = isShow;
//    self.loginBtn.enabled = self.userText.text.length && self.pwdText.text.length;
}

- (void)setupFrame {
    [_copyrightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(40));
        make.bottom.offset(-kWidth(30));
    }];
    
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(96));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(130));
        make.left.equalTo(self.lab2.mas_left).offset(0);
    }];
    
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(65));
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.offset(kHeight(120));
    }];
    
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(65));
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.offset(kHeight(120));
    }];

    [_errorMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneView.mas_bottom).offset(kHeight(10));
        make.centerX.equalTo(_phoneView.mas_centerX).offset(0);
    }];
    
    [_loginBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_errorMsgLab.mas_bottom).offset(kHeight(12));
        make.centerX.equalTo(_phoneView.mas_centerX).offset(0);
        make.width.offset(kWidth(295));
        make.height.offset(kWidth(50));
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(90));
        make.height.offset(kWidth(23));
        make.left.equalTo(_loginBtnView.mas_left).offset(0);
        make.top.equalTo(_loginBtnView.mas_bottom).offset(kHeight(160));
    }];
    

    
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(110));
        make.centerX.equalTo(_loginBtnView.mas_centerX).offset(0);
        make.height.offset(kWidth(23));
        make.top.equalTo(_loginBtnView.mas_bottom).offset(kHeight(16));
    }];
}

- (void)bubbleAction:(UIButton *)button {
    // 先缩小
    button.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:0 animations:^{
        // 放大
        button.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _phoneView = [[DRPhoneTextView alloc] init];
        [self addSubview:_phoneView];
        _phoneView.alpha = 0;
        _phoneView.delegate = self;
        
        _pwdView = [[DRPwdTextView alloc] init];
        _pwdView.delegate = self;
        _pwdView.alpha = 1;
        [self addSubview:_pwdView];
        
        
        [self initUI];
        [self setupFrame];
        [self.phoneView textChange:self.phoneView.phoneText];
    }
    return self;
}

+ (instancetype)loginView {
    return [[self alloc] init];
}

- (void)initUI {
    _copyrightImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"login_Copyright")];
        [self addSubview:imageView];
        imageView.hidden = YES;
        imageView;
    });
    
    _lab1 =({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(48)];
        label.textColor = RGB(80, 146, 255);
        label.text = @"智能监测";
        label;
    });
    
    _lab2 = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFangSC-Light" size:font(24)];
        label.textColor = RGB(74, 74, 74);
        label.text = @"欢迎登录";
        label;
    });
    
    
    
    _loginBtnView = ({
        DRLoginBtnView *view = [[DRLoginBtnView alloc] initWithFrame:CGRectMake(0, 0, kWidth(295), kHeight(50))];
        [self addSubview:view];
        view.bottomColor = RGB(215, 215, 215);
        view.progressValue = @"0";
        view.topLab.text = @"登录";
        
        view.time = 0.2;
        view.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        WEAKSELF
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [weakSelf loginBtnclick:view];
        }];
        [view addGestureRecognizer:tap];
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
    
    _registerBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:font(15)];
        [btn setTitleColor:[UIColor colorWithString:@"#4A4A4A"] forState:UIControlStateNormal];
        [btn setTitle:@"邀请码注册>" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn;
    });
    
    _switchBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:kGetImage(@"login_switch_btn_n") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:font(15)];
        [btn setTitleColor:[UIColor colorWithString:@"#4A4A4A"] forState:UIControlStateNormal];
        [btn setTitle:@" 手机验证登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        btn;
    });
}

- (void)switchBtnClick {

    //清除错误提示消息
    _errorMsgLab.hidden = NO;
    _errorMsgLab.text = @"";
    
    _switchBtn.enabled = NO;
    _switchBtn.alpha = 0;
    _loginBtnView.userInteractionEnabled = NO;
    _loginBtnView.alpha = 0;
    
    _phoneView.alpha = 0;
    _phoneView.userInteractionEnabled = NO;
    
    _pwdView.alpha = 0;
    _pwdView.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.5 animations:^{
        _switchBtn.alpha = 1;
        _switchBtn.enabled = !_switchBtn.enabled;
        _loginBtnView.alpha = 1;
        _loginBtnView.userInteractionEnabled = YES;
        
        if ([_switchBtn.titleLabel.text isEqualToString:kSwitchBtnTextPhone]) {
            [_switchBtn setTitle:kSwitchBtnTextUsername forState:UIControlStateNormal];
            _phoneView.alpha = 1;
            _phoneView.userInteractionEnabled = YES;
            //检查登录按钮是否可以亮起
            BOOL loginBtnEnabled ;
            loginBtnEnabled = self.phoneView.phoneText.text.length && self.phoneView.codeText.text.length;
            self.loginBtnView.progressValue = loginBtnEnabled?@"1":@"0";
            self.loginBtnView.userInteractionEnabled = loginBtnEnabled;
        }else {
            [_switchBtn setTitle:kSwitchBtnTextPhone forState:UIControlStateNormal];
            _pwdView.alpha = 1;
            _pwdView.userInteractionEnabled = YES;
            //检查登录按钮是否可以亮起
            BOOL loginBtnEnabled ;
            loginBtnEnabled = self.pwdView.userText.text.length && self.pwdView.pwdText.text.length;
            self.loginBtnView.progressValue = loginBtnEnabled?@"1":@"0";
            self.loginBtnView.userInteractionEnabled = loginBtnEnabled;
        }
    } completion:nil];
}
@end
