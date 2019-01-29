//
//  DRVerifyCodeButton.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRVerifyCodeButton.h"
@interface DRVerifyCodeButton()
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timestamp;
@end

@implementation DRVerifyCodeButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font =  [UIFont fontWithName:@"PingFang-SC-Light" size:font(14)];
    self.backgroundColor = [UIColor whiteColor];

    self.clipsToBounds = YES;
    [self setTitleColor:[UIColor colorWithString:@"#9B9B9B"] forState:UIControlStateNormal];//灰
    
    
    

}
- (void)observeApplicationActionNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)applicationDidEnterBackground {
    
    _timestamp = [NSDate date].timeIntervalSince1970;
    _timer.fireDate = [NSDate distantFuture];
}

- (void)applicationDidBecomeActive {
    
    NSTimeInterval timeInterval = [NSDate date].timeIntervalSince1970-_timestamp;
    _timestamp = 0;
    
    NSTimeInterval ret = _count -timeInterval;
    if (ret>0) {
        _count = ret;
        _timer.fireDate = [NSDate date];
    } else {
        _count = 0;
        _timer.fireDate = [NSDate date];
        [self timerFired];
//        [self timeFailBeginFrom:self.timer];
    }
}



- (void)timeFailBeginFrom:(NSInteger)timeCount {
    [self observeApplicationActionNotification];
    self.count = timeCount;
//    self.enabled = NO;
    
    // 加1个计时器
    [self timer];
}
- (void)timerFired {
    if (self.count >1) {
        self.count -= 1;
        self.isCountdown = YES;
        if ([self.delegate respondsToSelector:@selector(DRVerifyCodeBtnTimeStart:timeCount:)]) {
            [self.delegate DRVerifyCodeBtnTimeStart:self timeCount:self.count];
        }
    } else {
        self.isCountdown = NO;
        [self.timer invalidate];
        self.timer = nil;
        
        if ([self.delegate respondsToSelector:@selector(DRVerifyCodeBtnTimeEnd:)]) {
            [self.delegate DRVerifyCodeBtnTimeEnd:self];
        }
        
//        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor colorWithString:@"#5092FF"] forState:UIControlStateNormal];
        //        self.count = 60;
        
        // 停掉定时器
        
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
    return _timer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
