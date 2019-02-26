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
#import "DRJDHomeViewController.h"
#import "DRCollectViewController.h"

#import "DRCollectVC.h"

#import "DRScroller.h"

@interface DRHomeVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) DRProfileHomeViewController *profileHomeVC;
@property (nonatomic,strong) LoginVC *loginVC;
@end

@implementation DRHomeVC

{
    UIButton *selectBtn;
    UIScrollView *tabScroller;
    DRJDHomeViewController *JDHome;
    DRCollectViewController *JDCollect;
    UIButton *firstBtn;  //尽调任务
    UIButton *secondBtn; // 我的关注
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitleView];
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

    
    [self setContentView];
}

// 设置导航栏标签

-(void)setTitleView {
    
    self.navigationItem.leftBarButtonItem = nil;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
    firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn addTarget:self action:@selector(showNearby:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 1;
    selectBtn = firstBtn;
    [firstBtn.titleLabel setFont:[UIFont regulerApplicationFontOfSize:font(17)]];
    firstBtn.frame = CGRectMake(0, 0, 100, 30);
    [firstBtn setTitle:@"尽调项目" forState:UIControlStateNormal];
    [firstBtn setTitleColor:getUIColor(0xF2A949) forState:UIControlStateNormal];
    [titleView addSubview:firstBtn];
    secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(100, 0, 100, 30);
    secondBtn.tag = 2;
    [secondBtn.titleLabel setFont:[UIFont regulerApplicationFontOfSize:font(17)]];
    [secondBtn setTitle:@"我的关注" forState:UIControlStateNormal];
    [secondBtn setTitleColor:getUIColor(0xA9A9A9) forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(showNearby:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:secondBtn];
    self.navigationItem.titleView = titleView;
}

// 切换界面
-(void)showNearby:(UIButton *)sender
{
    [selectBtn setTitleColor:getUIColor(0xA9A9A9) forState:UIControlStateNormal];
    selectBtn = sender;
    [selectBtn setTitleColor:getUIColor(0xF2A949) forState:UIControlStateNormal];
    
    if (sender.tag == 1) {
        [tabScroller setContentOffset:CGPointMake(0, 0) animated:YES];
        
    } else {
        [tabScroller setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

-(void)setContentView {
    JDHome= [[DRJDHomeViewController alloc] init];
    [self addChildViewController:JDHome];
    JDCollect = [[DRCollectViewController alloc] init];
    [self addChildViewController:JDCollect];
    
    
    tabScroller = [[DRScroller alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tabScroller setContentSize:CGSizeMake(2 * SCREEN_WIDTH, 0)];
    [tabScroller setPagingEnabled:YES];
    tabScroller.delegate = self;
//    tabScroller.scrollEnabled = NO;
    tabScroller.showsVerticalScrollIndicator = FALSE;
    tabScroller.showsHorizontalScrollIndicator = FALSE;
    if (@available(iOS 11.0, *)) {
        tabScroller.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        
    }else {
        
        
    }
    [self.view addSubview:tabScroller];
    // 尽调任务
    
    [JDHome.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tabScroller addSubview:JDHome.view];



    // 我的关注
    [JDCollect.view setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [tabScroller addSubview:JDCollect.view];
}

#pragma mark - ScrollView delegate



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > SCREEN_WIDTH || scrollView.contentOffset.x < 0) {
        scrollView.scrollEnabled = NO;
    } else {
        scrollView.scrollEnabled = YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [selectBtn setTitleColor:getUIColor(0xA9A9A9) forState:UIControlStateNormal];
    
    if (scrollView.contentOffset.x == 0) {
        
        selectBtn = firstBtn;
        [selectBtn setTitleColor:getUIColor(0xF2A949) forState:UIControlStateNormal];
        
    } else {
        
        selectBtn = secondBtn;
        [selectBtn setTitleColor:getUIColor(0xF2A949) forState:UIControlStateNormal];
    }
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

- (void)logout {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [[request new ] logoutWithParams:dict net:^(DRBaseModel *data, RequestResult *result) {
        if ([data.code isEqualToString:@"401"] || [data.code isEqualToString:@"200"] ) {
            // 需要登录
            [self gotoLoginPage];
            
        } else {
            [[[TopAlert alloc] initWithStyle:[UIColor blackColor]] setHeaderTitle:data.errorMsg];
            return ;
        }
        
    } error:nil handleErrorCode:nil];
}
- (void)gotoLoginPage {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [UIApplication sharedApplication].keyWindow.rootViewController = self.loginVC;
    }
}

- (void)maskAnimationFromRight {
    
    [self presentViewController:[DRCollectVC new] animated:YES completion:nil];
    return;
    
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
