//
//  DRCollectDropView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectDropView.h"

@interface DRCollectDropView()
@property (nonatomic ,strong) UIImageView *image;
@property (nonatomic ,strong) UILabel *lab;


@end

@implementation DRCollectDropView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self setupFrame];
        [self showSelect:NO];
    }
    return self;
}


- (void)showSelect:(BOOL)isSelect {
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
- (void)setText:(NSString *)text {
    _lab.text = text;
}

- (void)setupFrame {
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kWidth(16));
    }];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kWidth(16));
        make.centerY.offset(0);
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
