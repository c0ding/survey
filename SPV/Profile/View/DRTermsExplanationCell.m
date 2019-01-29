//
//  DRTermsExplanationCell.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/5.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRTermsExplanationCell.h"



@implementation DRTermsExplanationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    self.termsLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.termsLabel];
    self.termsLabel.textColor = RGB(74, 74, 74);
    self.termsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    
    self.explanationLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.explanationLabel];
    self.explanationLabel.textColor = RGB(155, 155, 155);
    self.explanationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(15)];
    self.explanationLabel.numberOfLines = 0;
    self.explanationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGSize maximumLabelSize = CGSizeMake(kWidth(300), 9999);//labelsize的最大值
    CGSize expectSize = [self.explanationLabel sizeThatFits:maximumLabelSize];

    self.explanationLabel.size = CGSizeMake(expectSize.width, expectSize.height);
    

    self.explanationLabel.preferredMaxLayoutWidth = kWidth(290);
    self.explanationLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.leftImage = [[UIImageView alloc] initWithImage:kGetImage(@"TermsExplanation_q")];
    self.leftImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.leftImage];
    
    
    self.hyb_bottomOffsetToCell = kHeight(15);
    
    
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(20));
        make.top.offset(kHeight(25));
    }];
    
    [self.termsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImage.mas_right).offset(kWidth(6));
        make.centerY.equalTo(self.leftImage.mas_centerY).offset(0);
    }];
    
    [self.explanationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.termsLabel.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-kWidth(20));
        make.top.equalTo(self.termsLabel.mas_bottom).offset(kHeight(8));
        make.width.offset(kWidth(290));

//        make.right.mas_greaterThanOrEqualTo(self.contentView.mas_right).offset(-kWidth(40));
        
    }];
}

- (void)setupValueWithArray:(NSMutableArray *)data andIndexPath:(NSIndexPath *)indexPath {
    self.termsLabel.text = [data[indexPath.row] objectForKey:@"terms"];
    self.explanationLabel.text = [data[indexPath.row] objectForKey:@"explanation"];
}

@end
