//
//  DRAboutUsViewController.m
//  SPV
//
//  Created by 张逸阳 on 2017/9/13.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRAboutUsViewController.h"
#import "DRClauseLiabilityViewController.h"
@interface DRAboutUsViewController ()<UINavigationControllerDelegate>

@end

@implementation DRAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:kGetImage(@"profile_aboutUs_bgImg")];
    bgImage.frame = self.view.frame;
    [self.view addSubview:bgImage];
    
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:kGetImage(@"profile_aboutUs_logo")];
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bgImage.mas_top).offset(kHeight(70));
    }];
    
    UILabel *appNameLab = [UILabel new];
    appNameLab.textColor = DR_COR2;
    appNameLab.font = [UIFont systemFontOfSize:font(18)];
    appNameLab.text = @"智能监测 V1.2.3";
    [self.view addSubview:appNameLab];
    
    [appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(logoImage.mas_bottom).offset(kHeight(16));
    }];
    
    UILabel *specificationLab = [UILabel new];
    specificationLab.text = [NSString stringWithFormat:@"       %@",[DRPersonalCenterModel shareDRPersonalCenterModel].obj.aboutus?:@""];
//    @"       摩安资产是上海摩安资产  有限公司官方出品的应用。一款为投资者提供不良资产包处置进度查询，基础信息查询，以及智能分析的工具性软件。我们旨在将不良资产处置清收透明化，让投资人省心省力。";
    specificationLab.textColor = RGB(74, 74, 74);
    specificationLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:font(15)];
    specificationLab.numberOfLines = 0;
    [self.view addSubview:specificationLab];
    [specificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(appNameLab.mas_bottom).offset(kHeight(60));
        make.left.offset(kWidth(23));
        make.right.offset(-kWidth(23));
    }];
    
    UIButton *clauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:clauseBtn];
    [clauseBtn setTitle:@"免责条款" forState:UIControlStateNormal];
    [clauseBtn setTitleColor:DR_COR1 forState:UIControlStateNormal]; 
    [clauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(specificationLab.mas_bottom).offset(iPhone5?kHeight(140):kHeight(170));
    }];
    [clauseBtn addTarget:self action:@selector(clauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *companyNameLab = [UILabel new];
    companyNameLab.text = [DRPersonalCenterModel shareDRPersonalCenterModel].obj.company?:@"";
    
    [self.view addSubview:companyNameLab];
    companyNameLab.textColor = RGB(155, 155, 155);
    companyNameLab.font = [UIFont systemFontOfSize:font(15)];
    [companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(clauseBtn.mas_bottom).offset(kHeight(8));
    }];
    
    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    [buttonBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clauseBtnClick {
    DRClauseLiabilityViewController *nextVC = [[DRClauseLiabilityViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}

#pragma -mark 系统方法

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.delegate = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

@end
