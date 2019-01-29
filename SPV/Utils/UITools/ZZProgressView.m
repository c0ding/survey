//
//  ZZProgressView.m
//  MyProject
//
//  Created by 祝小夏 on 2017/5/2.
//  Copyright © 2017年 Tiny. All rights reserved.
//

#import "ZZProgressView.h"


@interface ZZProgressView ()
//@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *curentValueLabel;
@property (nonatomic, strong) UILabel *minValueLabel;
@property (nonatomic, strong) UILabel *maxValueLabel;
@property (nonatomic, strong) UILabel *centerValueLabel;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIImageView *thumbView;
@end

@implementation ZZProgressView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];

    
    //progress
    self.progressView = [[UIView alloc]init];
    self.progressView.backgroundColor = [UIColor lightTextColor];
    self.progressView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.progressView.layer.borderWidth = 0.5;
    
    self.leftView = [[UIView alloc]init];
    self.leftView.backgroundColor = self.leftValueTintColor;
    self.rightView = [[UIView alloc]init];
    self.rightView.backgroundColor = self.rightValueTintColor;
    self.separatorView = [[UIView alloc]init];
    self.separatorView.backgroundColor = [UIColor lightGrayColor];
    self.thumbView = [[UIImageView alloc]init];
    [self.thumbView setImage:self.thumbImage];
    self.thumbView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sliderValueChanged:)];
    [self.thumbView addGestureRecognizer:ges];
    
    self.minValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.minValueLabel.text = @"-100%";
    self.minValueLabel.font = [UIFont systemFontOfSize:font(13)];
    self.minValueLabel.textColor = [UIColor lightGrayColor];
    
    self.maxValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.maxValueLabel.text = @"+100%";
    self.maxValueLabel.font = self.minValueLabel.font;
    self.maxValueLabel.textAlignment = NSTextAlignmentRight;
    self.maxValueLabel.textColor = [UIColor lightGrayColor];
    
    self.centerValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.centerValueLabel.text = @"0%";
    self.centerValueLabel.font = self.minValueLabel.font;
    self.centerValueLabel.textAlignment = NSTextAlignmentCenter;
    self.centerValueLabel.textColor = [UIColor lightGrayColor];
    
    self.curentValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.curentValueLabel.text = @"0%";
    self.curentValueLabel.font = self.minValueLabel.font;
    self.curentValueLabel.textAlignment = NSTextAlignmentCenter;
    self.curentValueLabel.textColor = [UIColor blueColor];
    
    [self addSubview:self.progressView];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.separatorView];
    [self addSubview:self.minValueLabel];
    [self addSubview:self.maxValueLabel];
    [self addSubview:self.centerValueLabel];
    [self addSubview:self.curentValueLabel];
    [self addSubview:self.thumbView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressView.frame = CGRectMake(20, (CGRectGetHeight(self.frame)-10)/2.0, CGRectGetWidth(self.frame) - 40, 10);
    self.progressView.layer.cornerRadius = self.progressView.height / 2.0;
    
    CGFloat progressWidth = self.value * (self.progressView.width / 2.0);
    
    self.leftView.height = self.rightView.height = self.progressView.height;
    self.leftView.centerY = self.rightView.centerY = self.progressView.centerY;
    
    if (self.value > 0.0) {
        self.rightView.width = self.value * (self.progressView.width / 2.0);
        self.rightView.left = self.progressView.centerX;
    }
    else if (self.value < 0.0) {
        self.leftView.width = fabs(progressWidth);
        self.leftView.right = self.progressView.centerX;
    }
    
    self.thumbView.size = self.thumbImage.size;
    self.thumbView.centerY = self.progressView.centerY;
    self.thumbView.centerX = self.progressView.centerX + progressWidth;
    
    self.separatorView.size = CGSizeMake(2, self.progressView.height + 6);
    self.separatorView.center = self.progressView.center;
    
    self.minValueLabel.top =self.maxValueLabel.top =self.centerValueLabel.top = self.progressView.bottom + kHeight(10);
    self.centerValueLabel.centerX = self.progressView.centerX;
    self.maxValueLabel.right = self.width;
    
    self.curentValueLabel.bottom = self.thumbView.top - kHeight(1);
    self.curentValueLabel.centerX = self.thumbView.centerX;
    
    [self setCurrentValueText];
}

- (void)setThumbImage:(UIImage *)thumbImage {
    _thumbImage = thumbImage;
    [self.thumbView setImage:thumbImage];
}

- (void)setLeftValueTintColor:(UIColor *)leftValueTintColor {
    _leftValueTintColor = leftValueTintColor;
    self.leftView.backgroundColor = leftValueTintColor;
}

- (void)setRightValueTintColor:(UIColor *)rightValueTintColor {
    _rightValueTintColor = rightValueTintColor;
    self.rightView.backgroundColor = rightValueTintColor;
}

- (void)setValue:(float)value {
    float v1 = MIN(1, value);
    float v2 = MAX(-1, v1);
    _value = v2;
}



- (void)sliderValueChanged:(UIPanGestureRecognizer *)pan {
    if (self.value <0) {
        self.thumbImage = kGetImage(@"test_slider_green");
    }
    else
    {
        self.thumbImage = kGetImage(@"test_slider_blue");
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(slider:ValueChanged:)]) {
            [self.delegate slider:self ValueChanged:self.value];
        }
    }
    
    
    
    
    CGPoint point = [pan translationInView:self];
    
    CGFloat x = self.thumbView.centerX + point.x;
    CGFloat maxX = MAX(x, self.progressView.left);
    CGFloat minX = MIN(maxX, self.progressView.right);
    
    self.thumbView.centerX = minX;
    self.curentValueLabel.centerX = self.thumbView.centerX;
    
    self.value = ((self.thumbView.centerX - self.progressView.left) - (self.progressView.width / 2.0)) / (self.progressView.width / 2.0);
    
    [self setCurrentValueText];
    
    [pan setTranslation:CGPointZero inView:self];
}


- (void)setCurrentValueText {
    NSString *preStr = @"";
    if (self.value > 0.0) {
        preStr = @"+";
        self.leftView.width = 0;
        self.rightView.width = self.value * (self.progressView.width / 2.0);
        self.rightView.left = self.progressView.centerX;
        self.curentValueLabel.textColor = self.rightValueTintColor;
    }
    else if (self.value < 0.0) {
        preStr = @"-";
        self.rightView.width = 0;
        self.leftView.width = fabs(self.value) * (self.progressView.width / 2.0);
        self.leftView.right = self.progressView.centerX;
        self.curentValueLabel.textColor = self.leftValueTintColor;
    }
    else {
        preStr = @"";
        self.leftView.width = self.rightView.width = 0;
        self.curentValueLabel.textColor = self.rightValueTintColor;
    }
    
    NSString *currentValueText = [NSString stringWithFormat:@"%@%0.0f%@",preStr,fabs(self.value) * 100,@"%"];
    self.curentValueLabel.text = currentValueText;
}

@end
