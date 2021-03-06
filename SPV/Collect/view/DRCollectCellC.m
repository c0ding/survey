//
//  DRCollectCellC.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/21.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectCellC.h"

@interface DRCollectCellC()
@property (nonatomic ,strong) UILabel *leftLab;
@property (nonatomic ,strong) UILabel *rightLab;
@property (nonatomic ,strong) UILabel *zhuanhuanLab;

@property (nonatomic ,strong) UIView *leftLine;
@property (nonatomic ,strong) UIView *topLine;

@end

@implementation DRCollectCellC
- (void)setLeftTittle:(NSString *)leftTittle {
    self.leftLab.text = leftTittle;
    if ([leftTittle isEqualToString:@"土地面积"]) {
        self.leftLab.textColor = RGB(169, 169, 169);
    }
}

- (void)setCoverTittle:(NSString *)coverTittle {
    self.zhuanhuanLab.text = coverTittle;
}
- (void)setRightTittle:(NSString *)rightTittle{
    self.rightLab.text = rightTittle;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        
        [self setupFrame];
        
        
    }
    return self;
}


- (void)initUI {
    _leftLab = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(labFont)];
        label.textColor =  [UIColor colorWithRed:38/255.0 green:35/255.0 blue:30/255.0 alpha:1/1.0];
        
        [self.contentView addSubview:label];
        label.numberOfLines = 0;
        label;
    });
    
    _leftLine = ({
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
        view;
    });
    
    _topLine = ({
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
        view;
    });
    
    _rightLab = ({
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.numberOfLines = 0;
        label.text = @"土地面积";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(labFont)];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        label;
    });
    
    _zhuanhuanLab = ({
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(13)];
        label.textColor = [UIColor colorWithRed:73/255.0 green:146/255.0 blue:242/255.0 alpha:1/1.0];
        label;
    });
}

- (void)setupFrame {
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(topMargin));
        make.width.offset(kWidth(60));
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(84));
        make.top.equalTo(_rightLab.mas_top).offset(0);
        make.bottom.equalTo(_rightLab.mas_bottom).offset(0);
        make.width.offset(0.5);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.offset(0.5);
        make.width.offset(kScreenWidth);
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(topMargin));
        make.left.equalTo(_leftLine.mas_right).offset(kWidth(8.5));
        
    }];
    
    [_zhuanhuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(topMargin));
        make.right.offset(-kWidth(16));
        
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
