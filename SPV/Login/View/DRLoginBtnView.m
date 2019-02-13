//
//  DRLoginBtnView.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/20.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRLoginBtnView.h"
#import "ColorView.h"

@interface DRLoginBtnView()
{
    ColorView *viewTop;
    UIView *viewBottom;
    
}
@end
@implementation DRLoginBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    
    viewBottom = [[UIView alloc]initWithFrame:self.frame];
    viewBottom.backgroundColor = RGB(229, 229, 229);
    viewBottom.layer.cornerRadius = 2;
    viewBottom.layer.masksToBounds = YES;
    [self addSubview:viewBottom];
    
    
    NSMutableArray *colors = [NSMutableArray arrayWithArray:@[RGB(242, 169, 73),RGB(242, 169, 73)]];
    
    
    viewTop = [[ColorView alloc]initWithFrame:CGRectMake(0, 0, viewBottom.frame.size.width, viewBottom.frame.size.height) FromColorArray:colors ByGradientType:leftToRightView];
    [viewBottom addSubview:viewTop];
    _topLab = [[UILabel alloc] init];
    [self addSubview:_topLab];
    [_topLab bringSubviewToFront:self];
    _topLab.textColor = RGB(169, 169, 169);
    _topLab.textAlignment = NSTextAlignmentCenter;
    _topLab.frame = CGRectMake(0, 0, kWidth(80), kHeight(28));
//    _topLab.text = @"登录";
    _topLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(18)];
    _topLab.center = self.center;
}


- (void)setTopLab:(UILabel *)topLab {
    _topLab = topLab;
}
-(void)setProgressValue:(NSString *)progressValue {
    if (!_time) {
        _time = 0.0f;
    }
    _progressValue = progressValue;
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.duration = 0.4;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    anima.keyPath = @"shadowOffset";
    
    [UIView animateWithDuration:_time delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        

        viewTop.layer.transform = CATransform3DMakeScale(1*[progressValue floatValue], 1*[progressValue floatValue], 1);
        
        
        if ([progressValue isEqualToString:@"1"]) {
   
            _topLab.textColor = RGB(38, 35, 30);
        }else {
            
            _topLab.textColor = RGB(169, 169, 169);
        }
        

        [self setNeedsLayout];
        [self setNeedsDisplay];
        
        

        
    } completion:nil];
    
    
    

}



-(void)setTime:(float)time {
    _time = time;
}
-(void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
}

@end
