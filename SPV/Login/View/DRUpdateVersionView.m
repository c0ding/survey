//
//  DRUpdateVersionView.m
//  SPV
//
//  Created by 张逸阳 on 2018/7/24.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRUpdateVersionView.h"

@interface DRUpdateVersionView()
@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UIView *alertBgView;
@property (nonatomic ,strong) UIButton *cancelBtn;

@property (nonatomic ,strong) UIView *textBgView;
@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) UIButton *updateBtn;

@end

@implementation DRUpdateVersionView

- (instancetype)initWithFrame:(CGRect)frame andDRUpdateVersionModel:(DRUpdateVersionModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        _isContainsCancelBtn = !model.obj.force;
        self.tittleLab.text = model.obj.title;
        self.contentLab.text = model.obj.content;
        self.tagLab.text = [NSString stringWithFormat:@"  v%@  ",model.obj.latestVersion];
        
        [self bgView];
        self.alertBgView = [self alertBgViewWithHeight:[self getAlertBgViewHeight]];
        
        
        [self.alertBgView addSubview:self.textBgView];
        
        
        _textBgView.frame = CGRectMake(0, CGRectGetMaxY(self.topImg.frame)-1, _alertBgView.width, ([self getAlertBgViewHeight] - kGetImage(@"updateVersion_img").size.height -  (_isContainsCancelBtn? kHeight(88) :0)));
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_textBgView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kWidth(8), kWidth(8))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _textBgView.bounds;
        maskLayer.path = maskPath.CGPath;
        _textBgView.layer.mask = maskLayer;
        
        [self.textBgView addSubview:self.tittleLab];
        [self.textBgView addSubview:self.tagLab];
        [self.textBgView addSubview:self.contentLab];
        [self.textBgView addSubview:self.updateBtn];
        
        self.cancelBtn.hidden = !_isContainsCancelBtn;
        [self.alertBgView addSubview:self.cancelBtn];
        [self setupFrame];
        
    }
    return self;
}



- (void)setupFrame {
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.offset(0);
        make.width.offset(_alertBgView.width);
    }];

    [_tittleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.offset(0);
    }];
    
    [_tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tittleLab.mas_bottom).offset(kHeight(4));
        make.centerX.offset(0);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLab.mas_bottom).offset(kHeight(12));
        make.centerX.offset(0);
        make.width.offset(kWidth(200));
    }];
    
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLab.mas_bottom).offset(kHeight(24));
        make.centerX.offset(0);
        make.width.offset(kWidth(120));
        make.height.offset(kHeight(40));
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.centerX.offset(0);
        make.width.height.offset(kWidth(38));
    }];
    
}

- (CGFloat) getAlertBgViewHeight {
    CGFloat tittleLabH = [self.tittleLab.text boundingRectWithSize:CGSizeMake(kWidth(93), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:font(18)]} context:nil].size.height;
    
    
    
    CGFloat contentLabH = [self.contentLab.text boundingRectWithSize:CGSizeMake(kWidth(200), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:font(14)]} context:nil].size.height;

    
    return kGetImage(@"updateVersion_img").size.height + tittleLabH + kHeight(4) + kHeight(15) + kHeight(12) + contentLabH + kHeight(24) + kHeight(40) + kHeight(20) + (_isContainsCancelBtn? kHeight(88) :0);
}


- (UIView *)textBgView {
    if (!_textBgView) {

        _textBgView = [[UIView alloc] init];
        _textBgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _textBgView;
}
- (UIView *)alertBgViewWithHeight:(CGFloat )height {
    if(!_alertBgView){
        CGFloat w = kWidth(247);
        CGFloat x = kWidth(64);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, w, height)];
        
        [self.bgView addSubview:view];
        
        view.centerX = self.centerX;
        view.centerY = self.centerY;
        _alertBgView = view;
        
        _alertBgView.backgroundColor = [UIColor clearColor];
    }
    return _alertBgView;
}



- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:_bgView];
        _bgView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.65/1.0];
    }
    return _bgView;
}

- (UIImageView *)topImg {
    if (!_topImg) {
        _topImg = [[UIImageView alloc] initWithImage:kGetImage(@"updateVersion_img")];
        [self.alertBgView addSubview:_topImg];
       
    }
    return _topImg;
}

- (NSString * )contentText {
//    return  @";
    return @"-";
}
- (UILabel *)contentLab {
    if (!_contentLab) {
        UILabel *label = [[UILabel alloc] init];
        [self.textBgView addSubview: label];
        label.text = [self contentText];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(14)];
        label.textColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1/1.0];
        label.numberOfLines = 0;
        _contentLab = label;
    }
    return _contentLab;
}

-(UILabel *)tagLab {
    if (!_tagLab) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"  -  ";
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(11)];
        label.textColor = [UIColor colorWithString:@"#5092FF"];
        label.layer.borderColor = label.textColor.CGColor;
        label.layer.borderWidth = 1;
        _tagLab = label;
    }
    return _tagLab;
}

- (UILabel *)tittleLab {
    if (!_tittleLab) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"-";
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(18)];
        label.textColor = [UIColor colorWithRed:61/255.0 green:65/255.0 blue:80/255.0 alpha:1/1.0];
        _tittleLab = label;
    }
    return _tittleLab;
}
- (void)updateBtnAction:(UIButton *)sender {
    if (self.updateBtnClickBlcok) {
        self.updateBtnClickBlcok(sender);
    }
}
- (void)cancelBtnAction:(UIButton *)sender {
    if (self.cancelBtnClickBlcok) {
        self.cancelBtnClickBlcok(sender);
    }
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateBtn setBackgroundColor: [UIColor colorWithString:@"#5092FF"]];
        [_updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        _updateBtn.titleLabel.font = [UIFont systemFontOfSize:font(14)];
        [_updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(updateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _updateBtn.layer.cornerRadius = 4;
    }
    return _updateBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundImage:kGetImage(@"map_close") forState:UIControlStateNormal];
        _cancelBtn.layer.cornerRadius = kWidth(38*0.5);
        
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
