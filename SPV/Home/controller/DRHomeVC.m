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
@interface DRHomeVC ()
@property (nonatomic,strong) DRProfileHomeViewController *profileHomeVC;
@end

@implementation DRHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏 右边按钮 临时
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(maskAnimationFromRight)];
    
    // 注册手势驱动
    WEAKSELF
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
         if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf maskAnimationFromRight];
        }
    }];
    
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



@end
