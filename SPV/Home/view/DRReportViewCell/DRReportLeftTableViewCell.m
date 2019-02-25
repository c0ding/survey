//
//  DRReportLeftTableViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRReportLeftTableViewCell.h"

@implementation DRReportLeftTableViewCell
{
    UILabel *typeLabel;
    UILabel *nameLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    UIView *contentView = self.contentView;
    
    typeLabel = [UILabel new];
    [contentView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(20));
        
        make.top.offset(kHeight(17));
        make.right.lessThanOrEqualTo(contentView.mas_right).offset(-kWidth(10));
    }];
    [typeLabel setNumberOfLines:2];
    [typeLabel setFont:[UIFont regulerApplicationFontOfSize:font(11)]];
    [typeLabel setTextColor:getUIColor(0x26231E )];
    
    
    nameLabel = [UILabel new];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(20));
        make.right.offset( - kHeight(10));
        make.top.equalTo(typeLabel.mas_bottom).offset(kHeight(5));
        make.bottom.offset(- kHeight(15));
    }];
    
    [nameLabel setTextColor:getUIColor(0x26231E )];
    
    [nameLabel setNumberOfLines:3];
    
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

-(void)setModel:(DRCollectListModel *)model
{
    
    if (_selectTag == self.tag - 1) {
        [typeLabel setBackgroundColor:getUIColor(0xF2A949)];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:font(15)]];
        
    } else {
        [typeLabel setBackgroundColor:getUIColor(0xE5E5E5)];
        [nameLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    }
    
    [typeLabel setText:model.type];
    [nameLabel setText:model.guaranteeName];
}

@end
