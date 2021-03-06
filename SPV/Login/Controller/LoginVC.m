//
//  LoginVC.m
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

//#import "IQKeyboardReturnKeyHandler.h"
#import "ZYSliderViewController.h"
#import "DRProfileHomeViewController.h"

#import "CALayer+Transition.h"

#import "LHEnvManager.h"
#import "DRHomeVC.h"
#define kUserName @"kUserName"
#define kUserPhone @"kUserPhone"
@interface LoginVC ()<LoginViewDelegate>
@property (nonatomic ,strong) DRBaseNavigationViewController *baseNav;
@property (nonatomic ,strong) LoginView *loginView ;

@end

@implementation LoginVC
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self presentViewController:self.baseNav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // 切换环境
//    [self netConfig];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObserver];
    
    [self.loginView userName:@"18658123028" andPwd:@"000000"];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 150;//输入框到键盘的距离，默认为10
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    self.loginView.phoneView.phoneText.text = [userDefault objectForKey:kUserPhone]?:@"";
    //    self.loginView.pwdView.userText.text = [userDefault objectForKey:kUserName]?:@"";
    //    //分别验证当前文本框样式如何显示
    //    [self.loginView.phoneView textChange:self.loginView.phoneView.phoneText];
    //    [self.loginView.pwdView textChange];
    [__user logout];
}

- (void)loginViewLoginBtnClickWithUserName:(NSString *)userName andPwd:(NSString *)pwd {
    
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:userName forKey:@"userName"];
    [dict setValue:pwd forKey:@"password"];
    WEAKSELF
    [[request new] loginWithParams:dict net:^(DRBaseModel *data, RequestResult *result) {
        if (![data.code isEqualToString:@"200"]) {
            [[[TopAlert alloc]initWithStyle:[UIColor blackColor]] setHeaderTitle:data.errorMsg];
            return ;
        }
        [weakSelf presentViewController:weakSelf.baseNav animated:YES completion:nil];
    } error:^(RequestResult *result) {
        NSLog(@"213");
    } handleErrorCode:^(NSUInteger errorCode) {
        NSLog(@"21322");
    } ];
}

- (DRBaseNavigationViewController *)baseNav {
    if (!_baseNav) {
        DRHomeVC *homeVC = [[DRHomeVC alloc] init];
        _baseNav = [[DRBaseNavigationViewController alloc] initWithRootViewController:homeVC];
    }
    return _baseNav;
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


/// 选择url；/                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
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
