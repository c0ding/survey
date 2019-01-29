//
//  DRRegisterUsernameView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/24.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRRegisterUsernameView.h"
#import "DRLoginBtnView.h"
@interface DRRegisterUsernameView() <UITextFieldDelegate,DRPwdTextViewDelegate>
@property (nonatomic ,strong) UIView *stepLine;
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) DRLoginBtnView *nextBtnView;
///Copyright ©️ 2018 Mo
@property (nonatomic ,strong) UIImageView *copyrightImageView;
@end

@implementation DRRegisterUsernameView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}

- (void)initUI {
    _stepLine = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorWithString:@"#E2E4EB"];
        view;
    });
    
    _lab1 =({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(34)];
        label.textColor = RGB(0, 0, 0);
        label.text = @"设置账号";
        label;
    });
    
    _copyrightImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"login_Copyright")];
        [self addSubview:imageView];
        imageView;
    });

    
    _nextBtnView = ({
        DRLoginBtnView *view = [[DRLoginBtnView alloc] initWithFrame:CGRectMake(0, 0, kWidth(295), kHeight(50))];
        [self addSubview:view];
        view.bottomColor = RGB(215, 215, 215);
        view.progressValue = @"0";
        view.topLab.text = @"下一步";
        
        view.time = 0.2;
        view.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        WEAKSELF
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [weakSelf nextBtnclick:view];
        }];
        [view addGestureRecognizer:tap];
        view;
    });
    
    _errorMsgLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(12)];
        label.textColor = RGB(235, 103, 100);
        label.text = @"";
        label.hidden = YES;
        label;
    });
    
    
    _pwdTextView = [[DRPwdTextView alloc] init];
    _pwdTextView.delegate = self;
    [self addSubview:_pwdTextView];
    
}

- (void)setupFrame {
    [_stepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth*0.75);
        make.height.offset(2);
        make.top.equalTo(self.mas_top).offset(KIsiPhoneX?kHeight(28) :kHeight(22));
        make.left.equalTo(self.mas_left).offset(0);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(71));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
    }];
    
    [_pwdTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(65));
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.offset(kHeight(120));
    }];
    
    [_errorMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextView.mas_bottom).offset(kHeight(32));
        make.centerX.equalTo(self.pwdTextView.mas_centerX).offset(0);
    }];
    
    [_nextBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_errorMsgLab.mas_bottom).offset(kHeight(12));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.width.offset(kWidth(295));
        make.height.offset(kWidth(50));
    }];
    
    [_copyrightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(40));
        make.bottom.offset(-kWidth(30));
    }];
}


#pragma mark - 文本框内容改变事件
- (void)pwdTextChangeWithValue:(BOOL)isShow {
    self.errorMsgLab.text = @"";
    self.nextBtnView.progressValue = isShow?@"1":@"0";
    self.nextBtnView.userInteractionEnabled = isShow;
}

#pragma mark - 下一步按钮事件
- (void)nextBtnclick:(UIView *)button {
    self.errorMsgLab.text = @"";
    self.errorMsgLab.hidden = YES;
    
    if (![_pwdTextView.userText.text isUsername]) {
        self.errorMsgLab.text = @"用户名仅支持2-20位字母、数字组合";
        self.errorMsgLab.hidden = NO;
        return;
    }
    
    if (![_pwdTextView.pwdText.text isPSW]) {
        self.errorMsgLab.text = @"密码仅支持6-20位字母、半角标点、数字组合";
        self.errorMsgLab.hidden = NO;
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(nextBtnClick)]) {
        [self.delegate nextBtnClick];
    }
}

//    //设置去除的字符
//    NSCharacterSet *userTextSet = [NSCharacterSet characterSetWithCharactersInString:@"@／：()；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\",.`~!@#$%^&*()_+-="];
//
//    NSCharacterSet *pwdTextSet = [NSCharacterSet characterSetWithCharactersInString:@"@／：()；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
//
//
//    _pwdTextView.userText.text = [_pwdTextView.userText.text?:@"" stringByTrimmingCharactersInSet:userTextSet];

//    _pwdTextView.userText.text = [_pwdTextView.userText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    _pwdTextView.pwdText.text = [_pwdTextView.pwdText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
@end
