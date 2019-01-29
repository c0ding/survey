//
//  DRGuidePageSecond.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/26.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//
#define angle2Rad(angle) ((angle) / 180.0 * M_PI)
#import "DRGuidePageSecond.h"
@interface DRGuidePageSecond ()
@property (nonatomic ,strong)UIImageView *topImg;
@property (nonatomic ,strong)UIImageView *downImg;
@property (nonatomic ,strong)CAAnimationGroup *animationTop;
@property (nonatomic ,strong)CAAnimationGroup *animationDown;
@end

@implementation DRGuidePageSecond

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)startAnimation {
    [self.topImg.layer addAnimation:self.animationTop forKey:nil];
    [self.downImg.layer addAnimation:self.animationDown forKey:nil];
    [self addSubview:self.topImg];
    [self addSubview:self.downImg];
}
- (void)stopAnimation {
    [_topImg removeFromSuperview];
    [_topImg.layer removeAllAnimations];
    [_downImg removeFromSuperview];
    [_downImg.layer removeAllAnimations];
}
- (CAAnimationGroup *)animationTop {
    if (!_animationTop) {
        _animationTop = [CAAnimationGroup animation];
        _animationTop.autoreverses = NO;
        _animationTop.removedOnCompletion = NO;
        _animationTop.fillMode = kCAFillModeForwards;
        _animationTop.repeatCount = 1;
        _animationTop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CABasicAnimation *animaTopOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animaTopOpacity.fromValue = [NSNumber numberWithFloat: 0.f];
        animaTopOpacity.toValue = [NSNumber numberWithFloat:1];
        animaTopOpacity.duration = 0.3;
        
        CABasicAnimation *animaTopPosition = [CABasicAnimation animationWithKeyPath:@"position.y"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animaTopPosition.toValue = @(self.topImg.y+3);
        animaTopPosition.duration = 0.3;
        
        
        _animationTop.animations = @[animaTopOpacity,animaTopPosition];
        
    }
    return _animationTop;
}

- (CAAnimationGroup *)animationDown {
    if (!_animationDown) {
        _animationDown = [CAAnimationGroup animation];
        _animationDown.autoreverses = NO;
        _animationDown.removedOnCompletion = NO;
        _animationDown.fillMode = kCAFillModeForwards;
        _animationDown.repeatCount = 1;
        _animationDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        
        CABasicAnimation *animaDownOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animaDownOpacity.fromValue = [NSNumber numberWithFloat: 0.f];
        animaDownOpacity.toValue = [NSNumber numberWithFloat:1];
        animaDownOpacity.duration = 0.3;
        
        CABasicAnimation *animaDownPosition = [CABasicAnimation animationWithKeyPath:@"position.y"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animaDownPosition.toValue = @(self.downImg.y+3);
        animaDownPosition.duration = 0.3;
        
        _animationDown.animations = @[animaDownOpacity,animaDownPosition];
        
    }
    _animationDown.beginTime = CACurrentMediaTime() + 0.15;
    return _animationDown;
}
- (UIImageView *)topImg {
    if (!_topImg) {
        _topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight(145), kWidth(256), kGetImage(@"guidePage_second_up").size.height)];
        _topImg.image = kGetImage(@"guidePage_second_up");
        _topImg.centerX = self.centerX-kWidth(20);
        _topImg.alpha = 0;
    }
    return _topImg;
}

- (UIImageView *)downImg {
    if (!_downImg) {
        _downImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topImg.frame)+kHeight(5), kWidth(256), kGetImage(@"guidePage_second_down").size.height)];
        _downImg.image = kGetImage(@"guidePage_second_down");
        _downImg.centerX = self.centerX+kWidth(20);
        _downImg.alpha = 0;
    }
    return _downImg;
}

@end
