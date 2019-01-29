//
//  DRPlaceholderView.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/29.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRPlaceholderView.h"
@interface DRPlaceholderView ()
///图片
@property (nonatomic ,strong)UIImageView *imageView;
///第一行标题
@property (nonatomic ,strong)UILabel *titleLab;
///第二行标题
@property (nonatomic ,strong)UILabel *subTitleLab;
///刷新按钮
@property (nonatomic ,strong)UIButton *reloadBtn;


@end



@implementation DRPlaceholderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}



- (void)setupValueWithImgName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnTitle:(NSString *)btnTitle {
    
    
    [self.reloadBtn setTitle:btnTitle?:@"" forState:UIControlStateNormal];
    self.imageView.image = kGetImage(imageName);
    self.titleLab.text = title;
    self.subTitleLab.text = subTitle;
    
    if (btnTitle.length>0) {
        self.reloadBtn.hidden = NO;
    }else {
        self.reloadBtn.hidden=YES;
    }
    
    [self setupFrame];
    
}

- (void)setupFrame {
    if (self.imageView.image == nil) {
        self.titleLab.textColor = RGB(155, 155, 155);
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }else if (self.subTitleLab.text.length <1) {
        [_reloadBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.offset(kWidth(90));
            make.height.offset(kWidth(34)); make.top.equalTo(self.titleLab.mas_bottom).offset(kHeight(22));
        } ];
    }else {
        [self.subTitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(kHeight(8));
            make.centerX.offset(0);
            make.width.offset(kScreenWidth);
        }];
        
        [_reloadBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.offset(kWidth(90));
            make.height.offset(kWidth(34)); make.top.equalTo(self.subTitleLab.mas_bottom).offset(kHeight(40));
        } ];
    }
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    //------- 图片在正中间 -------//
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        [imageView sizeToFit];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(kHeight(123));
            make.centerX.offset(0);
        }];
        imageView;
    });
    
    //------- titleLab在图片下方 -------//
    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    label.textColor = RGB(74, 74, 74);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:font(18)];
    label.numberOfLines = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(kHeight(30));
        make.centerX.offset(0);
        make.width.offset(kWidth(169));
    }];
    [label setNumberOfLines:0];
    self.titleLab = label;
    
    //------- subTitleLab 在 titleLab下方 -------//
    UILabel *subLabel = [[UILabel alloc]init];
    [self addSubview:subLabel];
    subLabel.text = @"";
    subLabel.textColor = RGB(155, 155, 155);
    subLabel.font = [UIFont systemFontOfSize:font(15)];
    subLabel.textAlignment = NSTextAlignmentCenter;
    [subLabel setNumberOfLines:0];
    self.subTitleLab = subLabel;
    
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:reloadButton];
    reloadButton.titleLabel.text = @"";
    self.reloadBtn = reloadButton;
    [reloadButton setTitleColor:RGB(188, 188, 188) forState:UIControlStateNormal];
    [reloadButton setTitleColor:RGB(200, 200, 200) forState:UIControlStateHighlighted];
    reloadButton.layer.cornerRadius = 20;
    reloadButton.layer.borderColor = RGB(188, 188, 188).CGColor;
    reloadButton.layer.borderWidth = 1;
    reloadButton.hidden = NO;
    [reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.reloadBtn = reloadButton;
}


#pragma mark - 重新加载按钮点击
- (void)reloadButtonClicked:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(placeholderView:reloadButtonDidClick:)]) {
            [_delegate placeholderView:self reloadButtonDidClick:sender];
    }
}



#pragma mark - 返回按钮点击
- (void)backClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(placeholderView:backButtonDidClick:)]) {
            [_delegate placeholderView:self backButtonDidClick:sender];
    }
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(kWidth(15), kHeight(30), 40, 40)];
        buttonBack.hidden = YES;
        [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
        [self addSubview:buttonBack];
        [buttonBack addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = buttonBack;
    }
    return _backBtn;
}
@end
