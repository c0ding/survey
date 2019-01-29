//
//  ZZNullView.m
//  ZJHaobai
//
//  Created by 祝小夏 on 2017/5/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "ZZNullView.h"
#import "Masonry.h"
//#import "ZZMacros.h"
//#import "UIColor+ZZAdd.h"
@interface ZZNullView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ZZNullView

- (instancetype)initWithImage:(NSString *)imageName title:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        if (imageName.length > 0) {
            UIImage *img = [UIImage imageNamed:imageName];
            if (img) {
                _imageView = [[UIImageView alloc]init];
                _imageView.image = img;
                [self addSubview:_imageView];
                WEAKSELF
                [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(weakSelf.mas_centerY).with.offset(-40);
                    make.centerX.equalTo(weakSelf.mas_centerX);
                    make.size.mas_equalTo(CGSizeMake(img.size.width, img.size.height));
                }];
            }
        }
        if (title.length > 0) {
            _label = [[UILabel alloc]init];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.text = title;
            _label.numberOfLines = 0;
            _label.font = [UIFont systemFontOfSize:20];
            _label.textColor = [UIColor colorWithString:@"#9babb1"];
            [_label sizeToFit];
            [self addSubview:_label];
            WEAKSELF
            [_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_centerY);
                make.centerX.equalTo(weakSelf.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(weakSelf.label.frame.size.width, weakSelf.label.frame.size.height));
            }];
        }
    }
    return self;
}



@end
