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
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self setLayoutHeaderView];
    
    [self createShare];
}

-(void)createShare
{
    backView = [UIView new];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
    [backView addGestureRecognizer:tap];
    
    
    _shareView = [[DRShareView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    
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

-(void)clickShareButton:(NSInteger)index
{
    UMSocialPlatformType platform = UMSocialPlatformType_WechatSession ;
    switch (index) {
        case 0:
            platform = UMSocialPlatformType_WechatSession;
            break;
        case 1:
            platform = UMSocialPlatformType_WechatTimeLine;
            break;
        case 2:
            platform = UMSocialPlatformType_QQ;
            break;
       
    }
    
    [self shareWebPageToPlatformType:platform];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    [self cancelClick];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"智能监测系统 来自 杭州训机智能科技有限公司" descr:@"智能监测是一款向投资人开放的，披露不良资产包基础信息，跟踪资产包处置进度，智能分析利益最大化处置方案的工具型App" thumImage:[UIImage imageNamed:@"iconApp"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://appshare.baizeam.com/";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            
            
            if ([[error.userInfo stringForKey:@"message" ] isEqualToString:@"应用未安装"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[error.userInfo stringForKey:@"message" ] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }else{
            NSLog(@"response data is %@",data);
            
        }
    }];
}


- (void)setLayoutHeaderView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight(220))];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight(220))];
    self.headImageView.image = [UIImage imageNamed:@"profile_headBg_img"];
    UILabel *lab = [[UILabel alloc] init] ;
    self.nameLab = lab;
    [self.headImageView addSubview:lab];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldApplicationFontOfSize:font(38)];
    lab.text = @"";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.offset(kWidth(300));
    }];
    [headView addSubview:self.headImageView];
    
    
    UIButton *imageBack = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth -50, 0, 40, 40)];
    [imageBack setImage:[UIImage imageNamed:@"com_close_btn_n"] forState:UIControlStateNormal];
    [imageBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:imageBack];
    
    self.tableView.tableHeaderView = headView;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset < 0) {
        
        CGFloat totalOffset = kHeight(220) + ABS(yOffset);
        CGFloat f = totalOffset / kHeight(220);
        _headImageView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
    }
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
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
        case 3:{
            cell.leftLab.text = @"用户反馈";
            break;
        }
        
        case 4:{
            cell.leftLab.text = @"分享App";
            break;
        }
        default:
            break;
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
//            DRTermsExplanationViewController *nextVC = [[DRTermsExplanationViewController alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
            
            [self clearCache];
            break;
        }
        case 2:{
            DRAboutUsViewController *nextVC = [[DRAboutUsViewController alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 3:{
            DRUserFeedbackViewController *nextVC = [[DRUserFeedbackViewController alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 4:{
            [self showShareView];
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
        _tableView.rowHeight = kHeight(64);
        _tableView.sectionFooterHeight = kHeight(167);
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


-(void)backConroller {
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromRight;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}

-(void)backClick {
    [[self sliderViewController] hideLeft];
}


@end
