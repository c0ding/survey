//
//  TopAlert.m
//  TopAlert
//
//  Created by roycms on 2016/10/19.
//  Copyright © 2016年 roycms. All rights reserved.
//

#import "TopAlert.h"

@interface TopAlert()

@property(nonatomic,strong)UILabel *headerTitleLabel;
@property(nonatomic,strong)UILabel *contentTextLabel;
@property(nonatomic,strong)NSTimer *timer;

@end
@implementation TopAlert

- (instancetype)initWithStyle:(UIColor*)color {
    self = [super init];
    if (self) {
        [self initWindow:color];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initWindow:[UIColor redColor]];
    }
    return self;
}

-(void)initWindow:(UIColor*)color{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self addSubview:self.headerTitleLabel];
    [self addSubview:self.contentTextLabel];
    [self setBackgroundColor:color];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(window);
        make.width.equalTo(window);
    }];
    
    [self.headerTitleLabel setTextColor:[UIColor colorWithString:@"#E5E5E5"]];
    [self.contentTextLabel setFont:[UIFont systemFontOfSize:font(13)]];
    [self.contentTextLabel setTextColor:[UIColor whiteColor]];
    [self.contentTextLabel sizeToFit];
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KIsiPhoneX?35:kHeight(8));
        make.bottom.equalTo(self).offset(-8);
        make.left.equalTo(self).offset(kWidth(24));
        make.right.equalTo(self).offset(0);
    }];
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(44);
        make.bottom.equalTo(self).offset(-8);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self.contentTextLabel setAlpha:0];
    self.transform = CGAffineTransformMakeTranslation(0, -80);
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.contentTextLabel setAlpha:1];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.6 target:self selector:@selector(TopAlertAnimateSenior) userInfo:nil repeats:NO];
}
-(void)TopAlertAnimateSenior{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -80);
        [self.contentTextLabel setAlpha:0];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];

    }];
}

-(void)setHeaderTitle:(NSString *)headerTitle{
    [self.headerTitleLabel setText:headerTitle];
}
-(void)setContentText:(NSString *)contentText{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentText];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentText length])];
    [self.contentTextLabel setAttributedText:attributedString];
}

-(UILabel*)headerTitleLabel {
    if (_headerTitleLabel == nil) {
        _headerTitleLabel = [[UILabel alloc]init];
        [_headerTitleLabel setFont:[UIFont systemFontOfSize:font(13)]];
        [_headerTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_headerTitleLabel setTextColor:RGB(0, 0, 0)];
    }
    return _headerTitleLabel;
}

-(UILabel*)contentTextLabel {
    if (_contentTextLabel == nil) {
        _contentTextLabel = [[UILabel alloc]init];
        [_contentTextLabel setFont:[UIFont systemFontOfSize:13]];
        [_contentTextLabel setTextColor:RGB(0, 0, 0)];
        _contentTextLabel.numberOfLines = 0;
    }
    return _contentTextLabel;
}

-(void)dealloc{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.timer invalidate];
}

@end
