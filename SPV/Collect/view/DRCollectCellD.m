//
//  DRCollectCellD.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/21.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectCellD.h"

@interface DRCollectCellD()
@property (nonatomic ,strong) UILabel *leftLab;


@property (nonatomic ,strong) UIView *leftLine;
@property (nonatomic ,strong) UIView *topLine;
@property (nonatomic ,strong) UIView *contentsView;
@end

@implementation DRCollectCellD
- (void)setLeftTittle:(NSString *)leftTittle {
    self.leftLab.text = leftTittle;
    if ([leftTittle isEqualToString:@"土地面积"]) {
        self.leftLab.textColor = RGB(169, 169, 169);
    }
}

- (void)clickWithIndex:(NSInteger )index {
    
    if (self.clickBlock) {
        self.clickBlock(index);
    }
}
- (UIView *)createContentViewWith:(NSString *)text andIndex:(NSInteger)i{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kWidth(78+16), 0, kWidth(78), self.height)];
    view.userInteractionEnabled = YES;
    [self.contentsView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:kGetImage(@"attachment_img")];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.offset(0);
    }];

    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    WEAKSELF
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [weakSelf clickWithIndex:i];
    }];
    [label addGestureRecognizer:tap];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
    label.attributedText = attribtStr;
    [view addSubview:label];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(image.mas_right).offset(2);
        make.width.offset(kWidth(60));
    }];
//    label.text = text;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(15)];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    
    return view;
}

- (void)setContents:(NSArray<NSString *> *)contents {
    for (int i=0; i<contents.count; i++) {
        [self createContentViewWith:contents[i] andIndex:i];
    }
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
    
    _contentsView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kWidth(93), 0, kScreenWidth - kWidth(93), self.height)];
        [self.contentView addSubview: view];
        view;
    });
    
//    UILabel *label = [[UILabel alloc] init];
//    [self.contentView addSubview:label];
//    label.numberOfLines = 0;
//    label.text = @"土地面积";
//    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(labFont)];
//    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    

}

- (void)setupFrame {
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(topMargin));
        make.width.offset(kWidth(60));
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(84));
        make.top.equalTo(_leftLab.mas_top).offset(0);
        make.bottom.equalTo(_leftLab.mas_bottom).offset(0);
        make.width.offset(0.5);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.offset(0.5);
        make.width.offset(kScreenWidth);
    }];
    
//    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(kHeight(topMargin));
//        make.left.equalTo(_leftLine.mas_right).offset(kWidth(8.5));
//
//    }];
    
   
}

@end
