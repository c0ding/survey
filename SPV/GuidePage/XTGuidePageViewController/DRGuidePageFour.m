//
//  DRGuidePageFour.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/29.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRGuidePageFour.h"

@interface DRGuidePageFour ()
@property (nonatomic ,strong) UIImageView *mapImg;
@property (nonatomic ,strong) UIImageView *cardImg;
@property (nonatomic ,strong) UIImageView *emptyCardImg;
@end

@implementation DRGuidePageFour

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)startAnimation {
    [self addSubview:self.mapImg];
    [self addSubview:self.emptyCardImg];
    [self addSubview:self.cardImg];
    WEAKSELF
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.mapImg.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.cardImg.alpha = 1;
            _cardImg.y -= 10;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.emptyCardImg.alpha = 1;
                _emptyCardImg.y -= 10;
            }];
            
        }];
    }];
}
- (void)stopAnimation {
    [self.mapImg removeFromSuperview];
    [self.cardImg removeFromSuperview];
    [self.emptyCardImg removeFromSuperview];
    self.cardImg = nil;
    self.emptyCardImg = nil;
}
- (UIImageView *)mapImg {
    if (!_mapImg) {
        _mapImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight(200), kWidth(256), kGetImage(@"guidePage_four_group").size.height)];
        _mapImg.image = kGetImage(@"guidePage_four_group");
        _mapImg.centerX = self.centerX;
    }
    _mapImg.alpha = 0;
    return _mapImg;
}
- (UIImageView *)cardImg {
    if (!_cardImg) {
        _cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight(110), kWidth(208), kGetImage(@"guidePage_four_card").size.height)];
        _cardImg.centerX = self.centerX;
        _cardImg.image = kGetImage(@"guidePage_four_card");
    }
    _cardImg.alpha = 0;
    return _cardImg;
}
- (UIImageView *)emptyCardImg {
    if (!_emptyCardImg ) {
        _emptyCardImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight(115), kWidth(190), kGetImage(@"guidePage_four_emptyCard").size.height+kHeight(27))];
        _emptyCardImg.centerX = self.centerX;
        _emptyCardImg.image = kGetImage(@"guidePage_four_emptyCard");
    }
    _emptyCardImg.alpha = 0;
    return _emptyCardImg ;
}
@end
