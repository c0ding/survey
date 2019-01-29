//
//  DRClauseLiabilityViewController.m
//  SPV
//
//  Created by 张逸阳 on 2017/9/14.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRClauseLiabilityViewController.h"

@interface DRClauseLiabilityViewController ()<UINavigationControllerDelegate
>

@end

@implementation DRClauseLiabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"免责条款";
    self.navigationController.navigationBarHidden = NO;
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.text = [DRPersonalCenterModel shareDRPersonalCenterModel].obj.disclaimer?:@"" ;
//    @"1、一切移动客户端用户在下载并浏览APP软件时，均被视为已经仔细阅读并完全同意本条款内容。凡以任何方式登录本APP，或直接、间接使用本APP内容者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n 2、手机APP智能算法数据，以及操作建议，均由大数据模型计算所得，不提供任何法律保障。\n 3、用户明确并同意其使用APP手机网络服务所存在的风险将完全由其本人承担；因其使用手机APP网络服务而产生的一切后果也由其本人承担，手机APP对此不承担任何责任。 \n 4、除手机APP注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤及其所造成的任何损失，手机APP概不负责，亦不承担任何法律责任。 \n 5、对于因不可抗力或因黑客攻击、通讯线路中断等手机APP不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用手机APP，手机APP不承担任何责任，但将尽力减少因此给用户造成的损失或影响。 \n 6、本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。\n 7、本网站相关声明版权及其修改权、更新权和最终解释权均属手机APP所有。";
    label.textColor = RGB(74, 74, 74);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:font(15)];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(kWidth(343));
        make.top.offset(kHeight(17));
    }];
    
    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    [buttonBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma -mark 系统方法
-(void)viewDidDisappear:(BOOL)animated {
    self.navigationController.delegate = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
