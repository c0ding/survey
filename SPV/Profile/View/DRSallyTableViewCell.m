//
//  DRSallyTableViewCell.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/5.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRSallyTableViewCell.h"

@implementation DRSallyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    self.leftLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.leftLabel];
    self.leftLabel.textColor = RGB(74, 74, 74);
    self.leftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    self.leftLabel.text = @"『 ";
    
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rightLabel];
    self.rightLabel.textColor = RGB(74, 74, 74);
    self.rightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    self.rightLabel.text = @" 』";
    
    
    self.midImage = [[UIImageView alloc] initWithImage:kGetImage(@"login_pwd_img_s")];
    [self.contentView addSubview:self.midImage];
    
    self.explanationLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.explanationLabel];
    self.explanationLabel.textColor = RGB(155, 155, 155);
    self.explanationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(15)];
    self.explanationLabel.numberOfLines = 0;
    _explanationLabel.preferredMaxLayoutWidth = kWidth(280);
    self.explanationLabel.textAlignment = NSTextAlignmentLeft;
    [_explanationLabel sizeToFit];
    
    self.leftImage = [[UIImageView alloc] initWithImage:kGetImage(@"TermsExplanation_q")];
    self.leftImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.leftImage];
    
    
    self.hyb_bottomOffsetToCell = kHeight(15);
    
    
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(20));
        make.top.offset(kHeight(25));
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImage.mas_right).offset(kWidth(6));
        make.centerY.equalTo(self.leftImage.mas_centerY).offset(0);
    }];
    
    [self.midImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLabel.mas_centerY).offset(0);
        make.left.equalTo(self.leftLabel.mas_right).offset(3);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midImage.mas_right).offset(3);
        make.centerY.equalTo(self.leftLabel.mas_centerY).offset(0);
    }];
    
    [self.explanationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_left).offset(5);
        make.top.equalTo(self.leftLabel.mas_bottom).offset(kHeight(8));
//        make.right.mas_greaterThanOrEqualTo(self.contentView.mas_right).offset(-kWidth(40));
    }];
}

- (void)setupValueWithArray:(NSMutableArray *)data andIndexPath:(NSIndexPath *)indexPath {
    
    self.midImage.image = kGetImage([data[indexPath.row] objectForKey:@"imageName"]);
    self.explanationLabel.text = [data[indexPath.row] objectForKey:@"explanation"];
}
@end
