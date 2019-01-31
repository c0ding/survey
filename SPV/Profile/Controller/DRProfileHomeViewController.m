//
//  DRProfileHomeViewController.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/7.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRProfileHomeViewController.h"
#import "DRProfileHomeCell.h"
#import "DRUserFeedbackViewController.h"
#import "DRAboutUsViewController.h"
#import "UIViewController+ZYSliderViewController.h"
#import "ZYSliderViewController.h"
#import "LoginVC.h"
#import "ColorButton.h"
#import "XMGFileTool.h"
#import <UMShare/UMShare.h>

#import "DRTermsExplanationViewController.h"
#import "DRShareView.h"

#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface DRProfileHomeViewController ()<UITableViewDelegate,UITableViewDataSource,LGAlertViewDelegate,DRShareViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic, strong) DRShareView *shareView;
@end

@implementation DRProfileHomeViewController
{
    UIView *backView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithString:@"#FAFAFA"];
    //监听手机通知状态
    [self initUI];
    [self addObserver];
    [self personalCenterEngine];
}
- (void)addObserver {
    [[NSNotificationCenter defaultCenter]addObserverForName:kNotificationState object:nil queue:NSOperationQueuePriorityNormal usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
    }];
}
- (void)initUI {
    self.tableView.frame = CGRectMake(0, 0, kDistance, [UIScreen mainScreen].bounds.size.height);
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
}



-(void)showShareView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [backView setAlpha:0.6];
        [_shareView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    }];
}

-(void)cancelClick
{
    [UIView animateWithDuration:0.3 animations:^{
        [backView setAlpha:0.0];
        [_shareView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }];
}





#pragma mark -
#pragma mark 网络
#pragma mark === 获取个人信息
- (void)personalCenterEngine {
    @weakify(self);
//    [[request new] personalCenter:^(DRPersonalCenterModel *data, RequestResult *result) {
//        @strongify(self);
//
//
//
//        self.nameLab.text = data.obj.nickname?:@" ";
//
//
//        if ([data.code isEqualToString:kNoogin]) {
//            [self logoutEngine];
//        }
//
//
//    } error:^(RequestResult *result) {
//
//    } handleErrorCode:^(NSUInteger errorCode) {
//
//    }];
}


#pragma mark === 登出
- (void)logoutEngine {
//    LoginVC *loginVC=[LoginVC new];
//    [self.navigationController presentViewController:loginVC animated:NO completion:nil];
    
    
    
    @weakify(self);
//    [[request new]logoutWithNet:^(id data, RequestResult *result) {
//        @strongify(self);
//        [__user logout];
//        LoginVC *loginVC=[LoginVC new];
//        [self.navigationController presentViewController:loginVC animated:NO completion:nil];
//    } error:^(RequestResult *result) {
//        showAlert(result.errmsg, nil);
//    } handleErrorCode:^(NSUInteger errorCode) {
//        if (errorCode==500) {
//            @strongify(self);
//            LoginVC *loginVC=[LoginVC new];
//            [self.navigationController presentViewController:loginVC animated:NO completion:nil];
//        }
//    }];
}

#pragma mark -
#pragma mark 代理
#pragma mark === TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeight(157);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = @"王松";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(17)];
    label.textColor = RGB(38, 35, 30);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(30));
        make.left.offset(kWidth(16));
    }];
    
    return view;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRProfileHomeCell *cell =  [[DRProfileHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DRProfileHomeCellId"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            cell.leftLab.text = @"开启推送";
            cell.rightLab.text = [DRSharedApplication currentUserNotificationState]?@"已开启":@"已关闭";
            break;
        }
        case 1:{
            cell.leftLab.text = @"清除缓存";
            [XMGFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
                cell.rightLab.text = [NSString stringWithFormat:@"%ldM",totalSize];
                
            }];
            
            
//            cell.rightLab.text = [NSString stringWithFormat:@"%.0fM", [self folderSize]];
            break;
        }
        case 2:{
            cell.leftLab.text = @"关于我们";
            break;
        }
       
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *btnBgView = [[UIView alloc] init];
    [view addSubview:btnBgView];
    btnBgView.layer.shadowColor = RGB(212, 212, 212).CGColor;
    btnBgView.layer.shadowOpacity = 0.69f;
    btnBgView.layer.shadowOffset = CGSizeMake(1,3);
    btnBgView.layer.shadowRadius = 5.f;
    [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(40));
        make.left.offset(kWidth(28));
        make.right.offset(-kWidth(28));
    }];
    
    NSMutableArray *colorArray = [@[RGB(93, 182, 251),RGB(105, 127, 255)] mutableCopy];
    
    ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(0, 0, kWidth(319), kHeight(50)) FromColorArray:colorArray ByGradientType:leftToRight ];
    [btnBgView addSubview:btn];
    btn.layer.cornerRadius = 5.f;
    
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:font(16)];
    [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnBgView.mas_left).offset(0);
        make.top.equalTo(btnBgView.mas_top).offset(0);
        make.bottom.equalTo(btnBgView.mas_bottom).offset(0);
        make.right.equalTo(btnBgView.mas_right).offset(0);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self openNotification];
            break;
        }
        case 1:{
            [self clearCache];
            break;
        }
        case 2:{
            DRAboutUsViewController *nextVC = [[DRAboutUsViewController alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        
    }
}





#pragma mark -
#pragma mark 事件
#pragma mark === 清除缓存
- (void)clearCache {
    WEAKSELF
    
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@""
                                                        message:@"确定清除本地缓存？"
                                                          style:LGAlertViewStyleAlert
                                                   buttonTitles:@[@"确定"]
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                                      //清除缓存
//                                                      [MBManager showLoading];
                                                      
                                                      [XMGFileTool removeDirectoryPath:CachePath];
                                                     
                                                      [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
                                                      
                                                      [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0 ,0.6) ];   //背景颜色
                                                      
                                                      [SVProgressHUD showWithStatus:@"正在清除…"];
                                                      [SVProgressHUD dismissWithDelay:1 completion:^{
                                                          [SVProgressHUD dismissWithDelay:0.4];
                                                          [SVProgressHUD showSuccessWithStatus:@" 已清除 "];

                                                      }];
                                                      
                                                      [weakSelf.tableView reloadData];
                                                      
                                                  }
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    
    [self setupAlertViewStyle:alertView];
    [alertView showAnimated:YES completionHandler:nil];
}
#pragma mark === 设置通知
- (void)openNotification {
    WEAKSELF
    LGAlertView *alertView =
    [[LGAlertView alloc]
     initWithTitle:@"开启推送"
     message:@"开启或关闭智能监测的推送通知，请在“设置”-“通知”中找到“智能监测”进行操作"
     style:LGAlertViewStyleAlert
     buttonTitles:@[@"去设置"]
     cancelButtonTitle:@"取消"
     destructiveButtonTitle:nil
     actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
         [weakSelf jumpSetNotification];
         
     }
     cancelHandler:nil
     destructiveHandler:nil];
    

    [self setupAlertViewStyle:alertView];
    alertView.cancelOnTouch = NO;//点击空白处不取消
    [alertView showAnimated:YES completionHandler:nil];
}
//设置弹出框样式
- (void)setupAlertViewStyle:(LGAlertView*)alertView{
    
    alertView.titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
    alertView.titleTextColor = RGB(3, 3, 3);
    alertView.messageFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(13)];
    alertView.messageTextColor = RGB(3, 3, 3);
    alertView.cancelButtonTitleColor = RGB(155, 155, 155);
    alertView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    alertView.buttonsTitleColor = RGB(80, 146, 255);
    alertView.buttonsFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)];
}
#pragma mark === 跳转至设置通知
- (void)jumpSetNotification {
    //打开设置
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark === 登出提示
- (void)logout {
    WEAKSELF
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"提示"
                                                        message:@"确定退出登录吗？"
                                                          style:LGAlertViewStyleAlert
                                                   buttonTitles:@[@"退出"]
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                                      [weakSelf logoutEngine];
                                                  }
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    
    [self setupAlertViewStyle:alertView];
    [alertView showAnimated:YES completionHandler:nil];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = DR_BGCOR3;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
        _tableView.rowHeight = kHeight(52);
        _tableView.sectionFooterHeight = kHeight(351);
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}




@end
