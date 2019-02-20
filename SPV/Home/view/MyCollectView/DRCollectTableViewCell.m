//
//  DRCollectTableViewCell.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRCollectTableViewCell.h"
#import "DRCollectModel.h"
/**
 @property (nonatomic, strong) NSString *time;
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, assign) NSInteger projectType;
 @property (nonatomic, strong) NSString *type;
 @property (nonatomic, assign) NSInteger ifCollect;

 **/


@implementation DRCollectTableViewCell
{

    UILabel *timeLabel;
    UILabel *nameLabel;
    UILabel *projectTypeLabel;
    UILabel *typeLabel;
    UILabel *ifCollectLabel;
    
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUp];
        
    }
    return self;
}

-(void)setUp
{
    UIView *contentView = self.contentView;
    nameLabel = [UILabel new];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(16));
        make.height.offset(kHeight(21));
    }];
    [nameLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    [nameLabel setTextColor:getUIColor(0x26231E)];
    
    projectTypeLabel = [UILabel new];
    [contentView addSubview:projectTypeLabel];
    
    [projectTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.equalTo(nameLabel.mas_bottom).offset(kHeight(8));
        make.height.offset(kHeight(18));
    }];
    [projectTypeLabel.layer setCornerRadius:2];
    [projectTypeLabel.layer setMasksToBounds:YES];
    [projectTypeLabel setFont:[UIFont regulerApplicationFontOfSize:font(11)]];
    
    
    
    
    typeLabel = [UILabel new];
    [contentView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(projectTypeLabel.mas_right).offset(kWidth(4));
        make.top.equalTo(nameLabel.mas_bottom).offset(kHeight(8));
        make.height.offset(kHeight(18));
    }];
    [typeLabel.layer setCornerRadius:2];
    [typeLabel.layer setMasksToBounds:YES];
    [typeLabel setFont:[UIFont regulerApplicationFontOfSize:font(11)]];
    [typeLabel setTextColor:getUIColor(0x26231E)];
    [typeLabel setBackgroundColor:getUIColor(0xE5E5E5)];
    
    
    timeLabel = [UILabel new];
    [contentView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.bottom.offset( - kHeight(16));
        make.height.offset(kHeight(18));
    }];
    [timeLabel setFont:[UIFont regulerApplicationFontOfSize:font(13)]];
    [timeLabel setTextColor:getUIColor(0xA9A9A9)];
    
    
    
    
    ifCollectLabel = [UILabel new];
    [contentView addSubview:ifCollectLabel];
    
    [ifCollectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset( - kWidth(16));
        make.bottom.offset( - kHeight(16));
        make.height.offset(kHeight(18));
    }];
    [ifCollectLabel setFont:[UIFont regulerApplicationFontOfSize:font(13)]];
    [ifCollectLabel setTextColor:getUIColor(0xE5E5E5)];
    
    
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




-(void) setModel:(DRCollectListModel *)model
{
    [nameLabel setText:model.name];
    [projectTypeLabel setText: [[self projectInfo:model.projectType] objectForKey:@"name"]];
    [projectTypeLabel setBackgroundColor:[[self projectInfo:model.projectType] objectForKey:@"BGColor"]];
    [projectTypeLabel setTextColor:[[self projectInfo:model.projectType] objectForKey:@"textColor"]];
    
    [typeLabel setText:[NSString stringWithFormat:@" %@ ",model.type]];
    
    [timeLabel setText:model.time];
    
    [ifCollectLabel setText:model.ifCollect == 0 ? @"":@"已关注"];
    
}



-(NSMutableDictionary *)projectInfo :(NSInteger)sender
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    
    switch (sender) {
        case 0:
            [dic setObject:@" 无需尽调 " forKey:@"name"];
            [dic setObject:getUIColor(0xF2D9B6) forKey:@"BGColor"];
            [dic setObject:getUIColor(0x26231E) forKey:@"textColor"];
            break;
        case 1:
            [dic setObject:@" 待尽调 " forKey:@"name"];
            [dic setObject:getUIColor(0xB6CFF2) forKey:@"BGColor"];
            [dic setObject:getUIColor(0x26231E) forKey:@"textColor"];
            break;
        case 2:
            [dic setObject:@" 已尽调 " forKey:@"name"];
            [dic setObject:getUIColor(0xF2D9B6) forKey:@"BGColor"];
            [dic setObject:getUIColor(0x26231E) forKey:@"textColor"];
            break;
        default:
            break;
    }
    return dic;
    
}




















@end
