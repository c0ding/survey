//
//  DRReportRightTableViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRReportRightTableViewCell.h"

@implementation DRReportRightTableViewCell
{
    UILabel *titleLabel;
    UILabel *contentLabel;
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
    
    titleLabel = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(16));
        make.height.offset(kHeight(18));
        
    }];
    
    [titleLabel setTextColor:getUIColor(0x26231E)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:font(13)]];
    [titleLabel setText:@"项目描述"];
    
    
    contentLabel = [UILabel new];
    [contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.equalTo(titleLabel.mas_bottom).offset(kHeight(8));
        make.right.offset(-kWidth(16));
        make.bottom.offset(-kHeight(16));
    }];
    [contentLabel setTextColor:getUIColor(0x26231E)];
    [contentLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    [contentLabel setText:@"抵押物是位于舟山市普陀区沈家门街道兴建路157号的商业房产，土地面积6.14平米。土地使用期限至2047年2月27日，土地使用权类型用途为商业出让。建筑面积为50.63平米。建筑物成新度较高。抵押物位于舟山市普陀区沈家门街道。地理位置尚可，为万宇滨海新境的沿街商铺，紧靠兴建路，周边住宅小区较多，交通较便利，商业氛围较好，现场观察，出租为品牌服装折扣店，正常经营。经询问店家得知租金为一年75000，为一楼底商，层高较高。目前状态为出租，使用中。"];
    [contentLabel setNumberOfLines:0];
    
    
    
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
@end
