//
//  DRScrollView.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/12.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRScrollView.h"

@implementation DRScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_contentView];
    }
    return self;
}


#pragma mark - setters & getters

- (void)setContentSize:(CGSize)contentSize {
    [_contentView setFrame:CGRectMake(0.0, 0.0, contentSize.width, contentSize.height)];
    [super setContentSize:contentSize];
}

- (void)addSubview:(UIView *)view {
    if (_contentView == view) {
        [super addSubview:view];
    } else {
        [_contentView addSubview:view];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
