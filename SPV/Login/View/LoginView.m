///
//  LoginView.m
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "LoginView.h"
#import "DRLoginBtnView.h"
#import "DRLoginFormView.h"
@interface LoginView()
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) UIImageView *image1;
@property (nonatomic ,strong) UIImageView *image2;
@property (nonatomic ,strong) DRLoginFormView *nameView;
@property (nonatomic ,strong) DRLoginFormView *pwdView;
@property (nonatomic ,strong) DRLoginBtnView *loginBtnView;
@property (nonatomic ,strong) NSString *userNameStr;
@property (nonatomic ,strong) NSString *pwdStr;

@end
@implementation LoginView
#pragma mark - 登录按钮事件
- (void)loginBtnclick:(UIView *)button {
    if ([self.delegate respondsToSelector:@selector(loginViewLoginBtnClickWithUserName:andPwd:)]) {
        [self.delegate loginViewLoginBtnClickWithUserName:_userNameStr andPwd:_pwdStr];
    }

}

- (void)userName:(NSString *)userName andPwd:(NSString *)pwd {
    _userNameStr = userName;
    _pwdStr = pwd;
    _nameView.content = userName;
    _pwdView.content = pwd;
    [self checkout];
}



#pragma mark - 私有方法
#pragma mark 检查数据合法性
- (void)checkout {
    BOOL loginBtnEnabled ;
    loginBtnEnabled = _userNameStr.length && _pwdStr.length;
    self.loginBtnView.progressValue = loginBtnEnabled?@"1":@"0";
    self.loginBtnView.userInteractionEnabled = loginBtnEnabled;
}


#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}
- (void)initUI {
    WEAKSELF
    _lab1 =({
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.frame = CGRectMake(62, 145, 125, 32);
        label.text = @"DD 尽调工具";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(23)];
        label.textColor = [UIColor colorWithRed:38/255.0 green:35/255.0 blue:30/255.0 alpha:1/1.0];
        label;
    });
    
    _image1 = ({
        UIImageView *image = [[UIImageView alloc] initWithImage:kGetImage(@"logo")];
        [self addSubview:image];
        image;
    });
    
    _image2 = ({
        UIImageView *image = [[UIImageView alloc] initWithImage:kGetImage(@"login_bottom_img")];
        [self addSubview:image];
        image;
    });
    
    _nameView = [[DRLoginFormView alloc] init];
    _nameView.placeholder = @"请输入用户名";
    _nameView.title = @"用户名";
    
    _nameView.textChangeBlock = ^(NSString * _Nonnull str) {
        weakSelf.userNameStr = str;
        [weakSelf checkout];
    };
    [self addSubview:_nameView];
    
    _pwdView = [[DRLoginFormView alloc] init];
    _pwdView.placeholder = @"请输入密码";
    _pwdView.title = @"密码   ";
    _pwdView.secureTextEntry = YES;
    
    _pwdView.textChangeBlock = ^(NSString * _Nonnull str) {
        weakSelf.pwdStr = str;
        
        [weakSelf checkout];
    };
    [self addSubview:_pwdView];
    
    _loginBtnView = ({
        DRLoginBtnView *view = [[DRLoginBtnView alloc] initWithFrame:CGRectMake(0, 0, kWidth(327), kHeight(53))];
        [self addSubview:view];
        view.bottomColor = RGB(229, 229, 229);
        view.progressValue = @"0";
        view.topLab.text = @"登录";
        
        view.time = 0.2;
        view.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [weakSelf loginBtnclick:view];
        }];
        [view addGestureRecognizer:tap];
        view;
    });
}
- (void)setupFrame {
    
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(146));
        make.left.equalTo(self.mas_left).offset(kWidth(24));
    }];
    
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_image1.mas_centerY).offset(0);
        make.left.equalTo(_image1.mas_right).offset(kWidth(10));
    }];
    
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(24));
        make.right.equalTo(self.mas_right).offset(-kWidth(24));
        make.top.equalTo(_lab1.mas_bottom).offset(kHeight(48));
        make.height.offset(kHeight(53));
    }];
    
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(24));
        make.right.equalTo(self.mas_right).offset(-kWidth(24));
        make.top.equalTo(_nameView.mas_bottom).offset(kHeight(4));
        make.height.offset(kHeight(53));
    }];
    
    
    [_loginBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(327));
        make.height.offset(kWidth(53));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(_pwdView.mas_bottom).offset(kHeight(24));
    }];
}
+ (instancetype)loginView {
    return [[self alloc] init];
}

@end
