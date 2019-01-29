//
//  DRUserFeedbackViewController.m
//  SPV
//
//  Created by 张逸阳 on 2017/9/13.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRUserFeedbackViewController.h"

@interface DRUserFeedbackViewController ()<UINavigationControllerDelegate>
///说明
@property (nonatomic ,strong) UILabel *specificationLab;
@property (nonatomic ,strong) UIButton *phoneBtn;
@property (nonatomic ,strong) UIButton *mailBtn;
@property (nonatomic ,strong) UILabel *phoneLabel;
@property (nonatomic ,strong) UILabel *mailLabel;

@end

@implementation DRUserFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户反馈";
    UIImageView *image = [[UIImageView alloc] initWithImage:kGetImage(@"profile_feedback_bgImg")];
    image.frame = self.view.frame;
    [self.view addSubview:image];
    
    self.specificationLab.text = [NSString stringWithFormat:@"        %@",[DRPersonalCenterModel shareDRPersonalCenterModel].obj.userFeedback?:@""];
//    @"尊敬的用户，在你使用app过程中，\n 如有问题与建议，可通过以下方式与我们联系。\n长按可复制，感谢你的反馈！";
    
    self.phoneLabel.text = @"—— 联系电话 ——";
    [self.phoneBtn setTitle:[DRPersonalCenterModel shareDRPersonalCenterModel].obj.phone?:@"" forState:UIControlStateNormal];
    
    self.phoneBtn.userInteractionEnabled = [DRPersonalCenterModel shareDRPersonalCenterModel].obj.phone.length>0;
    
    self.mailLabel.text = @"—— 反馈邮箱 ——";
    [self.mailBtn setTitle:[DRPersonalCenterModel shareDRPersonalCenterModel].obj.email?:@"" forState:UIControlStateNormal];
    self.mailBtn.userInteractionEnabled = [DRPersonalCenterModel shareDRPersonalCenterModel].obj.email.length>0;
    
    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    [buttonBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}
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

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}

- (void)phoneBtnClick:(UIButton *)sender {
    if (![sender.titleLabel.text isKindOfClass:[NSString class]] || sender.titleLabel.text.length <= 0) {
        return;
    }
    [DRSharedApplication openTel:sender.titleLabel.text];
}
- (void)mailBtnClick:(UIButton *)sender {
    if (![sender.titleLabel.text isKindOfClass:[NSString class]] || sender.titleLabel.text.length <= 0) {
        return;
    }
    [DRSharedApplication openEmail:sender.titleLabel.text];
}

-(void)longPressToMail:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.mailBtn.titleLabel.text;
        [MBProgressHUD showAutoMessage:@"复制邮箱地址成功"];
    }
}

-(void)longPressToPhone:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.phoneBtn.titleLabel.text;
        [MBProgressHUD showAutoMessage:@"复制号码成功"];
    }
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel ) {
        _phoneLabel = [[UILabel alloc] init];
        [self.view addSubview:_phoneLabel];
        _phoneLabel.textColor = RGB(155, 155, 155);
        _phoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(12)];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(_specificationLab.mas_bottom).offset(kHeight(37));
        }];
        
    }
    return _phoneLabel;
}

- (UIButton *)phoneBtn {
    if (!_phoneBtn ) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_phoneBtn];
       
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToPhone:)];
        longPressGr.minimumPressDuration = 0.5;
        [_phoneBtn addGestureRecognizer:longPressGr];
        
        [_phoneBtn setBackgroundImage:kGetImage(@"profile_btn_bg") forState:UIControlStateNormal];
        [_phoneBtn setBackgroundImage:kGetImage(@"profile_btn_bg") forState:UIControlStateHighlighted];
        [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_phoneLabel.mas_bottom).offset(kHeight(12));
            make.centerX.offset(0);
        }];
        _phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, kHeight(7), 0);
    }
    return _phoneBtn;
}

- (UILabel *)mailLabel {
    if (!_mailLabel) {
        _mailLabel = [[UILabel alloc] init];
        _mailLabel.textColor = RGB(155, 155, 155);
        _mailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(12)];
        [self.view addSubview:_mailLabel];
        [_mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(_phoneBtn.mas_bottom).offset(kHeight(37));
        }];
    }
    return _mailLabel;
}

- (UIButton *)mailBtn {
    if (!_mailBtn ) {
        _mailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_mailBtn];
        [_mailBtn setBackgroundImage:kGetImage(@"profile_btn_bg") forState:UIControlStateNormal];
        [_mailBtn setBackgroundImage:kGetImage(@"profile_btn_bg") forState:UIControlStateHighlighted];
        [_mailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_mailBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToMail:)];
        longPressGr.minimumPressDuration = 0.5;
        [_mailBtn addGestureRecognizer:longPressGr];
        
        [_mailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_mailLabel.mas_bottom).offset(kHeight(12));
            make.centerX.offset(0);
        }];
        _mailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, kHeight(7), 0);
        [_mailBtn addTarget:self action:@selector(mailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBtn;
}

- (UILabel *)specificationLab {
    if (!_specificationLab ) {
        _specificationLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 91, kWidth(350), kHeight(63))];
        _specificationLab.textAlignment = NSTextAlignmentCenter;
        _specificationLab.font = [UIFont systemFontOfSize:font(15)];
        _specificationLab.numberOfLines = 0;
        _specificationLab.textColor = DR_COR2;
        [self.view addSubview:_specificationLab];
    }
    return _specificationLab;
}



@end
