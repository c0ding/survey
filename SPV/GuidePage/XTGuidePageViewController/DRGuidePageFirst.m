//
//  DRGuidePageFirst.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/25.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//
#define angle2Rad(angle) ((angle) / 180.0 * M_PI)
#import "DRGuidePageFirst.h"
@interface DRGuidePageFirst ()
@property (nonatomic ,strong)UIImageView *rightImg;
@property (nonatomic ,strong)UIImageView *leftImg;
@property (nonatomic ,strong)CABasicAnimation *animationRight;
@property (nonatomic ,strong)CABasicAnimation *animationLeft;

@end

@implementation DRGuidePageFirst
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth(190), kGetImage(@"guidePage_First_card").size.height)];
        [self addSubview:_rightImg];
        _rightImg.image = kGetImage(@"guidePage_First_card");
        _rightImg.center = self.center;
        
        [self rotatingPointWith:_rightImg andPoint:CGPointMake(1, 1)];
        
        _leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth(190), kGetImage(@"guidePage_First_card").size.height)];
        _leftImg.image = kGetImage(@"guidePage_First_card");
        [self addSubview:_leftImg];
        _leftImg.center = self.center;
        
        [self rotatingPointWith:_leftImg andPoint:CGPointMake(0, 1)];
    }
    return self;
}


- (void)startAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        _rightImg.alpha = 1;
        [_rightImg.layer addAnimation:self.animationRight forKey:nil];
        
        _leftImg.alpha = 1;
        [_leftImg.layer addAnimation:self.animationLeft forKey:nil];
    }];
    
}

- (void)stopAnimation {
    _leftImg.alpha = 0;
    [_leftImg.layer removeAllAnimations];
    
    _rightImg.alpha = 0;
    [_rightImg.layer removeAllAnimations];
}

/**
 设置控件某一顶点
 @param rotatingPoint 顶点    (0, 0);左上。(1, 0);右上。 (0, 1);左下。(1, 1);右下
 */
- (void)rotatingPointWith:(UIImageView *)imgView andPoint:(CGPoint )rotatingPoint {
    CGPoint oldOrigin = imgView.frame.origin;
    imgView.layer.anchorPoint = rotatingPoint;
    CGPoint newOrigin = imgView.frame.origin;
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    imgView.center = CGPointMake (imgView.center.x - transition.x, imgView.center.y - transition.y);
}

- (CABasicAnimation *)animationRight {
    if (!_animationRight) {
        _animationRight = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        _animationRight.fromValue = [NSNumber numberWithFloat: 0.f];
        _animationRight.toValue = [NSNumber numberWithFloat:angle2Rad(10)];
        _animationRight.duration = 0.5;
        _animationRight.autoreverses = NO;
        _animationRight.removedOnCompletion = NO;
        _animationRight.fillMode = kCAFillModeForwards;
        _animationRight.repeatCount = 1;
        _animationRight.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    return _animationRight;
}

- (CABasicAnimation *)animationLeft {
    if (!_animationLeft) {
        _animationLeft = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        _animationLeft.fromValue = [NSNumber numberWithFloat: 0.f];
        _animationLeft.toValue = [NSNumber numberWithFloat:-angle2Rad(10)];
        _animationLeft.duration = 0.5;
        _animationLeft.autoreverses = NO;
        _animationLeft.removedOnCompletion = NO;
        _animationLeft.fillMode = kCAFillModeForwards;
        _animationLeft.repeatCount = 1;
        _animationLeft.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    return _animationLeft;
}
@end
