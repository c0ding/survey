//
//  DRRegisterNicknameView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/15.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRRegisterNicknameView.h"
#import "DRLoginBtnView.h"
@interface DRRegisterNicknameView ()<UITextFieldDelegate>

@property (nonatomic ,strong) UIView *nicknameBgView;
@property (nonatomic ,strong) UIView *nicknameLine;

@property (nonatomic ,strong) UILabel *nicknameLab;
@property (nonatomic ,strong) DRLoginBtnView *nextBtnView;

@property (nonatomic ,strong) UIView *stepLine;
@property (nonatomic ,strong) UILabel *lab1;
///Copyright ©️ 2018 Mo
@property (nonatomic ,strong) UIImageView *copyrightImageView;
@end
@implementation DRRegisterNicknameView

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
        label.text = @"设置昵称";
        label;
    });
    
    _nicknameBgView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        _nicknameLine = [UIView new];
        [view addSubview:_nicknameLine];
        _nicknameLine.backgroundColor = RGB(220, 228, 240);
        _nicknameText = [UITextField new];
        [view addSubview:_nicknameText];
        _nicknameText.delegate = self;
        _nicknameText.textColor = RGB(0, 0, 0);
        _nicknameText.placeholder = @"请输入昵称";
        _nicknameText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _nicknameText.returnKeyType = UIReturnKeyDone;
        _nicknameText.textAlignment = NSTextAlignmentLeft;
        _nicknameText.font = [UIFont fontWithName:@"AvenirNext-Regular" size:font(18)];
        _nicknameText.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        _nicknameText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        [_nicknameText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
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
    
    _nextBtnView = ({
        DRLoginBtnView *view = [[DRLoginBtnView alloc] initWithFrame:CGRectMake(0, 0, kWidth(295), kHeight(50))];
        [self addSubview:view];
        view.bottomColor = RGB(215, 215, 215);
        view.progressValue = @"0";
        view.topLab.text = @"完成";
        
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
    
    _copyrightImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"login_Copyright")];
        [self addSubview:imageView];
        imageView;
    });
}

- (void)setupFrame {
    [_stepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth);
        make.height.offset(2);
        make.top.equalTo(self.mas_top).offset(KIsiPhoneX?kHeight(28) :kHeight(22));
        make.left.equalTo(self.mas_left).offset(0);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(71));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
    }];
    
    [_nicknameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(40));
        make.right.equalTo(self.mas_right).offset(-kWidth(40));
        make.height.offset(kHeight(80));
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(110));
    }];
    
    [_nicknameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nicknameBgView.mas_left).offset(0);
        make.right.equalTo(_nicknameBgView.mas_right).offset(0);
        make.bottom.equalTo(_nicknameBgView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_nicknameText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_nicknameBgView.mas_centerY).offset(0);
        make.left.equalTo(_nicknameBgView.mas_left).offset(0);
        make.right.equalTo(_nicknameBgView.mas_right).offset(0);
        make.bottom.equalTo(_nicknameBgView.mas_bottom).offset(0);
        
        //        make.right.equalTo(self.usernameView.mas_right).offset(0);
        make.height.offset(kHeight(52));
    }];
    
    [_errorMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameBgView.mas_bottom).offset(kHeight(32));
        make.centerX.equalTo(self.nicknameBgView.mas_centerX).offset(0);
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

///文本框内容改变
- (void)textChange {
    _errorMsgLab.text = @"";
    BOOL loginBtnEnabled ;
    loginBtnEnabled = self.nicknameText.text.length;
    self.nextBtnView.progressValue = loginBtnEnabled?@"1":@"0";
    self.nextBtnView.userInteractionEnabled = loginBtnEnabled;
    //    self.loginBtn.enabled = self.userText.text.length && self.pwdText.text.length;
}

#pragma mark - 下一步按钮事件
- (void)nextBtnclick:(UIView *)button {
    self.errorMsgLab.text = @"";
    self.errorMsgLab.hidden = YES;
    self.nicknameText.text = [self.nicknameText.text?:@"" stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if (self.nicknameText.text.length<2 || self.nicknameText.text.length>10) {
        self.errorMsgLab.text = @"2-10位字符，支持中英文数字";
        self.errorMsgLab.hidden = NO;
        return;
    }
    if ([self.delegate respondsToSelector:@selector(nextBtnClick)]) {
        [self.delegate nextBtnClick];
    }
}
@end
