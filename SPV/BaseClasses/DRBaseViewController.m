//
//  DRBaseViewController.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/29.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRBaseViewController.h"
#import "PushTransition.h"
#import "DRUpdateVersionView.h"
@interface DRBaseViewController ()<UINavigationControllerDelegate>
@property (nonatomic ,strong)DRPlaceholderView *placeholderView;
@property (nonatomic ,strong)DRUpdateVersionView *updateVersionView;


@end

@implementation DRBaseViewController


//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    if (self.navigationController.delegate == self) {
//        self.navigationController.delegate = nil;
//    }
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC {

//   
//        return [[PushTransition alloc] init];
//   

//

//

//}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)hiddenPlaceholderView {
    [self.placeholderView removeFromSuperview];
    self.placeholderView = nil;
}
- (void)showPlaceholderViewWithImgName:(NSString *)imgName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnTitle:(NSString *)btnTitle {
    
    [self.view addSubview:self.placeholderView];
    [self.view bringSubviewToFront:_placeholderView];
    [self.placeholderView setupValueWithImgName:imgName andTitle:title andSubTitle:subTitle andBtnTitle:btnTitle];
}

- (void)showBackBtnWithHiddelState:(BOOL )isHiddel {
    self.placeholderView.backBtn.hidden = isHiddel;
    if (!self.placeholderView.backBtn.hidden) {
        _placeholderView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
}
- (void)placeholderView:(DRPlaceholderView *)placeholderView backButtonDidClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(DRPlaceholderView *)placeholderView {
    if (!_placeholderView) {
        if (_haveNONavi) {
            _placeholderView = [[DRPlaceholderView alloc ] initWithFrame:CGRectMake(0, KIsiPhoneX ? 84:64, kScreenWidth, kScreenHeight)];
        } else {
            _placeholderView = [[DRPlaceholderView alloc ] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        }
        
        [self.view addSubview:_placeholderView];
        _placeholderView.delegate = self;
        self.placeholderView.backBtn.hidden = YES;
    }
    return _placeholderView;
}

#pragma mark === 版本更新 弹窗提示
- (void)toUpdateWithDRUpdateVersionModel:(DRUpdateVersionModel*)model {
     WEAKSELF
    [self updateVersionViewDRUpdateVersionModel:model];
    
     self.updateVersionView.updateBtnClickBlcok = ^(id sender) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kToAppStoreUrl]];
     } ;
     
     self.updateVersionView.cancelBtnClickBlcok = ^(id sender) {
         //非强制更新时，取消后，做版本记录，该版本不再弹窗提醒更新
         if (!model.obj.force) {
             
             [[NSUserDefaults standardUserDefaults] setObject:appVersion() forKey:kUpdateDidPop];
             //在存入当前点击取消的 时间戳+2天 、+x天
             //启动时拿当前时间 与 存入的时间戳 做判断，如果时间戳
             //小于 , 说明用户这段时间已经取消过，无须弹窗
             //大于 , 把 kUpdateDidPop 的值移除，弹窗提醒。
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [weakSelf.updateVersionView removeFromSuperview];
         }
     } ;
}






//设置弹出框样式
- (void)setupAlertViewStyle:(LGAlertView*)alertView{
    alertView.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
    alertView.titleTextColor = RGB(3, 3, 3);
    alertView.messageFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(13)];
    alertView.messageTextAlignment = NSTextAlignmentLeft;
    alertView.messageTextColor = RGB(3, 3, 3);
    alertView.cancelButtonTitleColor = RGB(155, 155, 155);
    alertView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    alertView.buttonsTitleColor = RGB(80, 146, 255);
    alertView.buttonsFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
}

- (DRUpdateVersionView *)updateVersionViewDRUpdateVersionModel :(DRUpdateVersionModel *)model {
    if (!_updateVersionView) {
        _updateVersionView = [[DRUpdateVersionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andDRUpdateVersionModel:model];
        [[DRSharedApplication delegate].window addSubview:_updateVersionView];
        [[DRSharedApplication delegate].window bringSubviewToFront:_updateVersionView];
    }
    return _updateVersionView;
}

@end


//- (void)updateWithDRUpdateVersionModel:(DRUpdateVersionModel*)model{
//    if (self.updateAlertView.isShowing) {
//        return;
//    }
//    self.updateAlertView =
//    [[LGAlertView alloc]
//     initWithTitle:model.obj.title
//     message:model.obj.content
//     style:LGAlertViewStyleAlert
//     buttonTitles:@[@"去更新"]
//     cancelButtonTitle:model.obj.force?nil:@"取消"
//     destructiveButtonTitle:nil
//     actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
//         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kToAppStoreUrl]];
//     }
//     cancelHandler:^(LGAlertView * _Nonnull alertView) {
//         //非强制更新时，取消后，做版本记录，该版本不再弹窗提醒更新
//         if (!model.obj.force) {
//
//             [[NSUserDefaults standardUserDefaults] setObject:model.obj.versionCode forKey:kUpdateDidPop];
//             //在存入当前点击取消的 时间戳+2天 、+x天
//             //启动时拿当前时间 与 存入的时间戳 做判断，如果时间戳
//             //小于 , 说明用户这段时间已经取消过，无须弹窗
//             //大于 , 把 kUpdateDidPop 的值移除，弹窗提醒。
//             [[NSUserDefaults standardUserDefaults] synchronize];
//         }
//     }
//     destructiveHandler:nil];
//    self.updateAlertView.cancelOnTouch = NO;
//    [self setupAlertViewStyle:self.updateAlertView];
//    [self.updateAlertView showAnimated:YES completionHandler:nil];
//
//}
