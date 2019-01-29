//
//  DRShareButtonCollectionViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2018/7/27.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRShareButtonCollectionViewCell.h"

@implementation DRShareButtonCollectionViewCell
{
    UIImageView *iconImage;
    UILabel *titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    UIView *contentView = self.contentView;
    
    iconImage = [UIImageView new];
    [contentView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(16);
        make.width.offset(53.9);
        make.height.offset(53.9);
    }];
    
    titleLabel = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(iconImage.mas_bottom).offset(8.1);
        make.height.offset(17);
    }];
    [titleLabel setFont:[UIFont regulerApplicationFontOfSize:12]];
    [titleLabel setTextColor:getUIColor(0x7C7C7C)];
    
}

-(void)setShareDic:(NSDictionary *)shareDic
{
    [iconImage setImage:[UIImage imageNamed:[shareDic stringForKey:@"imageName"]]];
    [titleLabel setText:[shareDic stringForKey:@"shareTitle"]];
}

@end
