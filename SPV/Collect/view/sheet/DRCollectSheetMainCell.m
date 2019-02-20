//
//  DRCollectSheetMainCell.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/18.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectSheetMainCell.h"

@interface DRCollectSheetMainCell()
@property (nonatomic ,strong) UIImageView *image;
@property (nonatomic ,strong) UILabel *lab;
@end
@implementation DRCollectSheetMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        [self setupFrame];
        self.isSelect = NO;
        
    }
    return self;
}

- (void)setText:(NSString *)text {
    _lab.text = text;
}

- (void)setIsSelect:(NSInteger)isSelect {
    if (isSelect) {
        _image.hidden = NO;
        _lab.textColor = [UIColor colorWithRed:242/255.0 green:169/255.0 blue:73/255.0 alpha:1/1.0];
    }else {
        _image.hidden = YES;
        _lab.textColor =  [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1/1.0];
    }
}

- (void)initUI {
    _lab = ({
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.text = @"";
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(15)];
        label.textColor = [UIColor colorWithRed:242/255.0 green:169/255.0 blue:73/255.0 alpha:1/1.0];
        label;
    });
    
    _image = ({
        UIImageView *image = [[UIImageView alloc] initWithImage:kGetImage(@"collect_status")];
        [self addSubview:image];
        image;
    });
}


- (void)setupFrame {
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_lab.mas_left).offset(-kWidth(8));
        make.centerY.offset(0);
    }];
}


@end
