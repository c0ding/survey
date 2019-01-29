//
//  DRProfileHomeCell.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/7.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRProfileHomeCell.h"

@interface DRProfileHomeCell ()
///分割线
@property (nonatomic ,strong) UIView *separatorLine;
///右边箭头
@property (nonatomic ,strong) UIImageView *nextImg;
@end

@implementation DRProfileHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}
- (void)initUI {
    _leftLab = [[UILabel alloc] init];
    [self.contentView addSubview:_leftLab];
    _leftLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(15)];
    _leftLab.textColor = RGB(74, 74, 74);
    
    _rightLab = [[UILabel alloc] init];
    [self.contentView addSubview:_rightLab];
    _rightLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:font(15)];
    _rightLab.textColor = RGB(155, 155, 155);
    
    _separatorLine = [UIView new];
    [self.contentView addSubview:_separatorLine];
    _separatorLine.backgroundColor = RGB(245, 245, 245);
    
    _nextImg = [[UIImageView alloc] initWithImage:kGetImage(@"com_canNext_img")];
    [self.contentView addSubview:_nextImg];
}
-(void)setupFrame {
    [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
    }];
    
    [_nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kWidth(28));
        make.centerY.offset(0);
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kWidth(28));
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(_nextImg.mas_left).offset(-kWidth(8));
    }];
}
@end
