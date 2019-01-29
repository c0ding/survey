//
//  DRGuidePageThird.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/26.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRGuidePageThird.h"

@interface DRGuidePageThird ()
@property (nonatomic ,strong) UIImageView *mapImg;
//@property (nonatomic ,strong) CABasicAnimation *mapAnimation;
@property (nonatomic ,strong) UIImageView *dotImg;
@property (nonatomic ,strong) CABasicAnimation *dotAnimation;
@property (nonatomic ,strong) UIImageView *cardImg;
@property (nonatomic ,strong) UIImageView *emptyCardImg;
@end

@implementation DRGuidePageThird

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)startAnimation {
    [self addSubview:self.mapImg];
    [self addSubview:self.dotImg];
    [self addSubview:self.emptyCardImg];
    [self addSubview:self.cardImg];
    WEAKSELF
    
    [UIView animateWithDuration:0.4 animations:^{
        _mapImg.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _dotImg.alpha = 1;
            _dotImg.transform = CGAffineTransformScale(_dotImg.transform, 1.3, 1.3);
           
            _cardImg.alpha = 1;
            _cardImg.y -= kHeight(10);
            
        }  completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _emptyCardImg.alpha = 1;
                _emptyCardImg.y -= kHeight(10);
            } ];
        }];
    }];
}
- (void)stopAnimation {
    [self.mapImg removeFromSuperview];
    [self.dotImg removeFromSuperview];
    [self.cardImg removeFromSuperview];
    [self.emptyCardImg removeFromSuperview];
    self.cardImg = nil;
    self.dotImg = nil;
    self.emptyCardImg = nil;
}

- (CABasicAnimation *)dotAnimation {
    
    if (!_dotAnimation) {
        _dotAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale    "];
//        _dotAnimation.fromValue = [NSNumber numberWithFloat: 0.4f];
        _dotAnimation.toValue = [NSNumber numberWithFloat:1];
        _dotAnimation.duration = 0.3;
        _dotAnimation.autoreverses = NO;
        _dotAnimation.removedOnCompletion = NO;
        _dotAnimation.fillMode = kCAFillModeForwards;
        _dotAnimation.repeatCount = 1;
        _dotAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    return _dotAnimation;

}

- (UIImageView *)dotImg {
    if (!_dotImg) {
        _dotImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mapImg.frame)-kWidth(50), kWidth(50), kWidth(50))];
        _dotImg.image = kGetImage(@"guidePage_third_dot");
        _dotImg.centerX = self.centerX;
    }
    _dotImg.alpha = 0;
    return _dotImg;
}

- (UIImageView *)mapImg {
    if (!_mapImg) {
        _mapImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight(200), kWidth(256), kHeight(96))];
        _mapImg.image = kGetImage(@"guidePage_third_map");
        _mapImg.centerX = self.centerX;
    }
    _mapImg.alpha = 0;
    return _mapImg;
}
- (UIImageView *)cardImg {
    if (!_cardImg) {
        _cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight(103), kWidth(208), kGetImage(@"guidePage_third_card").size.height)];
        _cardImg.centerX = self.centerX;
        _cardImg.image = kGetImage(@"guidePage_third_card");
    }
    _cardImg.alpha = 0;
    return _cardImg;
}
- (UIImageView *)emptyCardImg {
    if (!_emptyCardImg ) {
        _emptyCardImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight(107), kWidth(190), kGetImage(@"guidePage_third_emptyCard").size.height+kHeight(25))];
        _emptyCardImg.centerX = self.centerX;
        _emptyCardImg.image = kGetImage(@"guidePage_third_emptyCard");
    }
    _emptyCardImg.alpha = 0;
    return _emptyCardImg ;
}
@end
