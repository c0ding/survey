
//
//  DRInviteCodeView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRInviteCodeView.h"
#import "DRLoginBtnView.h"
#define MAX_STARWORDS_LENGTH 6
@interface DRInviteCodeView ()<UITextFieldDelegate>

@property (nonatomic ,strong) UIView *codeBgView;
@property (nonatomic ,strong) UIView *codeLine;
@property (nonatomic ,strong) UIView *stepLine;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) DRLoginBtnView *nextBtnView;


@property (nonatomic ,strong) UILabel *lab1;
///Copyright ©️ 2018 Mo
@property (nonatomic ,strong) UIImageView *copyrightImageView;

@end
@implementation DRInviteCodeView
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
        label.text = @"邀请码注册";
        label;
    });
    
    _codeBgView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        _codeLine = [UIView new];
        [view addSubview:_codeLine];
        _codeLine.backgroundColor = RGB(220, 228, 240);
        _codeText = [UITextField new];
        [view addSubview:_codeText];
        _codeText.delegate = self;
        _codeText.textColor = RGB(0, 0, 0);
        _codeText.keyboardType = UIKeyboardTypeASCIICapable;
        _codeText.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止首字母大写
        _codeText.returnKeyType = UIReturnKeyDone;
        _codeText.textAlignment = NSTextAlignmentCenter;
        _codeText.font = [UIFont fontWithName:@"AvenirNext-Regular" size:font(38)];
        _codeText.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        _codeText.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
        [_codeText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        view;
    });
    
    _errorMsgLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(12)];
        label.textColor = RGB(235, 103, 100);
        label.text = @"邀请码不存在";
        label.hidden = YES;
        label;
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
    
    _copyrightImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"login_Copyright")];
        [self addSubview:imageView];
        imageView;
    });
}

- (void)setupFrame {
    [_stepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth*0.25);
        make.height.offset(2);
        make.top.equalTo(self.mas_top).offset(KIsiPhoneX?kHeight(28) :kHeight(22));
        make.left.equalTo(self.mas_left).offset(0);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kHeight(71));
        make.left.equalTo(self.mas_left).offset(kWidth(40));
    }];
    
    [_codeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kHeight(80));
        make.width.offset(kWidth(190));
        make.top.equalTo(self.lab1.mas_bottom).offset(kHeight(110));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    
    [_codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeBgView.mas_left).offset(0);
        make.right.equalTo(_codeBgView.mas_right).offset(0);
        make.bottom.equalTo(_codeBgView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [_codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.centerY.equalTo(_codeBgView.mas_centerY).offset(0);
        make.width.offset(kWidth(180));
        //        make.right.equalTo(self.usernameView.mas_right).offset(0);
        make.height.offset(kHeight(52));
    }];
    
    [_errorMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBgView.mas_bottom).offset(kHeight(32));
        make.centerX.equalTo(self.codeBgView.mas_centerX).offset(0);
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
- (void)textChange:(UITextField *)textField {
    _errorMsgLab.text = @"";
    
    BOOL loginBtnEnabled ;
    loginBtnEnabled = self.codeText.text.length;
    self.nextBtnView.progressValue = loginBtnEnabled?@"1":@"0";
    self.nextBtnView.userInteractionEnabled = loginBtnEnabled;
    [self textMaxLength:textField];
    
}

///限制最多字符数量
- (void)textMaxLength:(UITextField *)textField{
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}
#pragma mark - 下一步按钮事件
- (void)nextBtnclick:(UIView *)button {
    //    // 先缩小
    //    button.transform = CGAffineTransformMakeScale(0.9, 0.9);
    //
    //    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    //    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:0 animations:^{
    //        // 放大
    ////        button.transform = CGAffineTransformMakeScale(1, 1);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    if ([self.delegate respondsToSelector:@selector(nextBtnClick)]) {
        [self.delegate nextBtnClick];
    }
}
@end
