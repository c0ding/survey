//
//  DRHomeTableViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/19.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRHomeTableViewCell.h"
#import "DRJDHomeModel.h"
#import "DRMockData.h"
@implementation DRHomeTableViewCell


{
    UILabel *numberLabel;
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
    
    numberLabel = [UILabel new];
    [contentView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.centerY.offset(0);
        make.height.offset(kHeight(18));
    }];
    [numberLabel setTextColor:getUIColor(0x26231E)];
    [numberLabel setFont:[UIFont regulerApplicationFontOfSize:font(16)]];
    
    
    nameLabel = [UILabel new];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.centerY.offset(0);
        make.height.offset(kHeight(21));
    }];
    [nameLabel setTextColor:getUIColor(0x26231E)];
    [nameLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    
    UIView *lineView = [UIView new];
    [contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(42));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(0.5);
    }];
    [lineView setBackgroundColor:getUIColor(0xE5E5E5)];

    
}


-(void)setModel:(DRTimeListModel *)model
{
    NSArray *array = [[DRMockData shareDRMockData] numberCircle];
    [numberLabel setText:array[self.tag - 1]];
    [nameLabel setText:model.assetPackageName];
    
}

@end
