//
//  DRCollectNavView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectNavView.h"

@interface DRCollectNavView()
@property (nonatomic ,strong)UIButton *leftBtn;
@property (nonatomic ,strong)UIButton *rightBtn;
@property (nonatomic ,strong)UIButton *centerBtn;
@end

@implementation DRCollectNavView

- (void)showBtn:(BOOL)isShow {
    self.leftBtn.hidden = isShow;
    self.rightBtn.hidden = isShow;
}



- (void)leftBtnClick {
    if (self.leftClickBlock) {
        self.leftClickBlock();
    }
}
- (void)rightBtnClick {
    if (self.rightClickBlock) {
        self.rightClickBlock();
    }
}

- (void)centerBtnClick {
    if (self.centerClickBlock) {
        self.centerClickBlock();
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self initUI];
        [self setupframe];
    }
    return self;
}

- (void)initUI {
    _leftBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setImage:kGetImage(@"nav_b_close_n") forState:UIControlStateNormal];
        [btn setImage:kGetImage(@"nav_b_close_s") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:font(15)];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:RGB(242, 169, 73 ) forState:UIControlStateNormal];
        btn;
    });
    
    _centerBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setTitle:@"待尽调" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:font(17)];
        [btn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:RGB(255, 255, 255 ) forState:UIControlStateNormal];
        btn;
    });
}

- (void)setText:(NSString *)text {
     [_centerBtn setTitle:text forState:UIControlStateNormal];
}

- (void)setupframe {
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kWidth(20));
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-kWidth(16));
    }];
    
    [_centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset(0);
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
