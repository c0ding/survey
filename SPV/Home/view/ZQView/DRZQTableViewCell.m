//
//  DRZQTableViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/19.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRZQTableViewCell.h"
#import "DRZQListModel.h"
@implementation DRZQTableViewCell
{
    UILabel* numberLabel;
    UILabel* nameLabel;
    UILabel* scheduleDec;
    UIView * amoutCountView;
    UIView * currentCountView;
    UILabel *lookReport;
    UIImageView *enterImg;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
    }
    return self;
}

-(void)setUp {
    
    UIView *contentView = self.contentView;
    
    numberLabel = [UILabel new];
    [contentView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(16));
        make.height.offset(kHeight(22));
    }];
    [numberLabel setFont:[UIFont boldSystemFontOfSize:font(17)]];
    [numberLabel setTextColor:getUIColor(0x26231E)];
    
    
    
    
    nameLabel = [UILabel new];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.top.offset(kHeight(17));
        make.height.offset(kHeight(21));
    }];
    [nameLabel setTextColor:getUIColor(0x26231E)];
    [nameLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    
    
    scheduleDec = [UILabel new];
    [contentView addSubview:scheduleDec];
    [scheduleDec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.top.equalTo(nameLabel.mas_bottom).offset(kHeight(15));
        make.height.offset(kHeight(18));
    }];
    [scheduleDec setTextColor:getUIColor(0x666666)];
    [scheduleDec setFont:[UIFont regulerApplicationFontOfSize:font(14)]];
    
    
    
    amoutCountView = [UIView new];
    [contentView addSubview:amoutCountView];
    [amoutCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.bottom.offset(- kHeight(15));
        make.width.offset(kWidth(250));
        make.height.offset(kHeight(4));
    }];
    [amoutCountView.layer setCornerRadius:kHeight(2)];
    [amoutCountView.layer setMasksToBounds:YES];
    [amoutCountView setBackgroundColor:getUIColor(0xF2F2F2)];
    
    
    
    currentCountView = [UIView new];
    [contentView addSubview:currentCountView];
    [currentCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.bottom.offset(- kHeight(15));
        make.width.offset(kWidth(250));
        make.height.offset(kHeight(4));
    }];
    [currentCountView.layer setCornerRadius:kHeight(2)];
    [currentCountView.layer setMasksToBounds:YES];
    [currentCountView setBackgroundColor:getUIColor(0xF2A949)];
    
    lookReport = [UILabel new];
    [contentView addSubview:lookReport];
    [lookReport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amoutCountView.mas_right).offset(kWidth(16));
        make.top.equalTo(nameLabel.mas_bottom).offset(kHeight(20));
        make.height.offset(kHeight(18));
    }];
    [lookReport setTextColor:getUIColor(0xF2A949)];
    [lookReport setText:@"查看报告"];
    [lookReport setFont:[UIFont regulerApplicationFontOfSize:font(13)]];
    
    
    enterImg = [UIImageView new];
    [contentView addSubview:enterImg];
    [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.right.offset(-16);
        make.height.offset(16);
        make.width.offset(16);
    }];
    [enterImg setImage:[UIImage imageNamed:@"ZQEnter"]];
    
    
    UIView *lineView = [UIView new];
    [contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(0.5);
    }];
    [lineView setBackgroundColor:getUIColor(0xE5E5E5)];
}

-(void)setModel:(DRZQListDetailModel *)model
{
    [numberLabel setText:[NSString stringWithFormat:@"%02ld",self.tag]];
    [nameLabel setText:model.obligatoryRightName];
    [scheduleDec setText:[NSString stringWithFormat:@"尽调进度：%.0f/%.0f", model.numerator,model.denominator]];
    
    [currentCountView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kHeight((model.denominator == 0 ? 0 : ( model.numerator / model.denominator * 250))));
    }];
    
    [lookReport setHidden:model.denominator == 0 ? YES : NO];
}



@end
