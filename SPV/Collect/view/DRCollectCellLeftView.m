//
//  DRCollectCellLeftView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/15.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectCell.h"

@interface DRCollectCell()
@property (nonatomic ,strong) UILabel *leftLab;
@property (nonatomic ,strong) NSString *leftTittle;

@property (nonatomic ,strong) UIView *leftLine;
@end

@implementation DRCollectCell

- (void)setLeftTittle:(NSString *)leftTittle {
    self.leftLab.text = leftTittle;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        
        [self setupFrame];
        
        self.leftTittle = @"地址";
        
    }
    return self;
}

- (void)initUI {
    _leftLab = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(15)];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        [self.contentView addSubview:label];
        label;
    });
    
    _leftLine = ({
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
        view;
    });
}

- (void)setupFrame {
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(16));
        make.width.offset(kWidth(84));
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLab.mas_right).offset(0);
        make.top.equalTo(_leftLab.mas_top).offset(0);
        make.bottom.equalTo(_leftLab.mas_bottom).offset(0);
        make.width.offset(0.5);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
