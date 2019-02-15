//
//  DRHomeVC.m
//  SPV
//
//  Created by 张逸阳 on 2019/1/31.
//  Copyright © 2019年 hejiahuan. All rights reserved.
//

#import "DRHomeVC.h"
#import "UIViewController+CWLateralSlide.h"
#import "DRProfileHomeViewController.h"
#import "LoginVC.h"

#import "DRCollectVC.h"
@interface DRHomeVC ()
@property (nonatomic,strong) DRProfileHomeViewController *profileHomeVC;
@property (nonatomic,strong) LoginVC *loginVC;
@end

@implementation DRHomeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏 右边按钮 临时
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(maskAnimationFromRight)];
    
    // 注册手势驱动
    WEAKSELF
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf maskAnimationFromRight];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutAlert) name:kLogout object:nil];
    
}


#pragma mark === 登出提示
- (void)logoutAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:@"标题的提示信息" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self collectPage];
}
- (void)collectPage {
    DRCollectVC *collectVC = [[DRCollectVC alloc] init];
    [self presentViewController:collectVC animated:YES completion:nil];
}
- (void)logout {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [UIApplication sharedApplication].keyWindow.rootViewController = self.loginVC;
    }
}

- (void)maskAnimationFromRight {
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.showAnimDuration = 0.5f;
    conf.distance = kDistance;
    conf.maskAlpha = 0.72;
    [self cw_showDrawerViewController:self.profileHomeVC animationType:CWDrawerAnimationTypeMask configuration:conf];
}

- (DRProfileHomeViewController *)profileHomeVC {
    if (_profileHomeVC == nil) {
        _profileHomeVC = [[DRProfileHomeViewController alloc] init];
    }
    return _profileHomeVC;
}



- (LoginVC *)loginVC {
    if (!_loginVC) {
        _loginVC = [[LoginVC alloc] init];
    }
    return _loginVC;
}
@end
