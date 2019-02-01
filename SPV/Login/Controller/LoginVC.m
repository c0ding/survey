//
//  LoginVC.m
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

#import "IQKeyboardReturnKeyHandler.h"
#import "ZYSliderViewController.h"
#import "DRProfileHomeViewController.h"

#import "CALayer+Transition.h"
#import "IQKeyboardManager.h"
#import "LHEnvManager.h"
#import "DRHomeVC.h"
#define kUserName @"kUserName"
#define kUserPhone @"kUserPhone"
@interface LoginVC ()<LoginViewDelegate>
@property (nonatomic ,strong) LoginView *loginView;

@end

@implementation LoginVC
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DRHomeVC *homeVC = [[DRHomeVC alloc] init];
    DRBaseNavigationViewController *baseNav = [[DRBaseNavigationViewController alloc] initWithRootViewController:homeVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = baseNav;
    
//    [self presentViewController:baseNav animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // 切换环境
    [self netConfig];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObserver];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 150;//输入框到键盘的距离，默认为10
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.loginView.phoneView.phoneText.text = [userDefault objectForKey:kUserPhone]?:@"";
    self.loginView.pwdView.userText.text = [userDefault objectForKey:kUserName]?:@"";
    //分别验证当前文本框样式如何显示
    [self.loginView.phoneView textChange:self.loginView.phoneView.phoneText];
    [self.loginView.pwdView textChange];
    [__user logout];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVersion:) name:kToUpdateNotification object:nil];
}

- (void)updateVersion:(NSNotification *)note {
    DRUpdateVersionModel *data = (DRUpdateVersionModel*)note.object;
    if (data.obj.force == YES) {
        [self toUpdateWithDRUpdateVersionModel:data];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter ] removeObserver:self name:kToUpdateNotification object:nil];
}

#pragma mark -
#pragma mark 设置UI
#pragma mark === 初始化UI
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginView.frame = self.view.bounds;
}



    




#pragma mark === 未注册 弹窗提示
- (void)noRegistPopupWithMessage:(NSString *)message {
    WEAKSELF
    LGAlertView *alertView =
    [[LGAlertView alloc]
     initWithTitle:@"提示"
     message:message
     style:LGAlertViewStyleAlert
     buttonTitles:@[@"去注册"]
     cancelButtonTitle:@"取消"
     destructiveButtonTitle:nil
     actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
         [weakSelf loginViewRegisterBtnClick];
     }
     cancelHandler:nil
     destructiveHandler:nil];
    alertView.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
    alertView.titleTextColor = RGB(3, 3, 3);
    alertView.messageFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(13)];
    alertView.messageTextColor = RGB(3, 3, 3);
    alertView.cancelButtonTitleColor = RGB(155, 155, 155);
    alertView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    alertView.buttonsTitleColor = RGB(80, 146, 255);
    alertView.buttonsFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
    [alertView showAnimated:YES completionHandler:nil];
}



- (void)whiteUserNameToUserDefault {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginView.phoneView.phoneText.text?:@"" forKey:kUserPhone];
    [userDefault setObject:self.loginView.pwdView.userText.text?:@"" forKey:kUserName];
}

/// 选择url
- (void)netConfig{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchNetwork)];
    tapGesture.numberOfTapsRequired = 2; //点击次数
    tapGesture.numberOfTouchesRequired = 2; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
}
- (void)switchNetwork {
//#ifdef DEBUG
//
//#else
//#endif
    
    [[LHEnvManager shareManager] showSwitch];
}

#pragma mark -
#pragma mark get/set
#pragma mark === loginView
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [LoginView loginView];
        _loginView.delegate = self;
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

@end
