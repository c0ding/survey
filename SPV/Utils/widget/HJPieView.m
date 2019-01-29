//
//  HJPieView.m
//  thrallplus
//
//  Created by HeJia on 16/8/9.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJPieView.h"


@implementation HJPieDataStruct

+(HJPieDataStruct *)create:(CGFloat)val color:(UIColor *)col
{
    HJPieDataStruct *pieData = [HJPieDataStruct new];
    pieData.val = val;
    pieData.color = col;
    return pieData;
}

@end


@interface HJPieView()
{
    CGFloat _total;
}

@end

@implementation HJPieView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype) init{
    if(self = [super init]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) setAryData:(NSArray<HJPieDataStruct *> *)aryData{
    _aryData = aryData;
    
    for(HJPieDataStruct *pieData in _aryData){
        _total += pieData.val;
    }
    NSLog(@"====%lf",_total);
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height)/2;
    CGFloat startAngle = 0;
    CGPoint ptCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [[UIColor clearColor] setStroke];
    for(HJPieDataStruct *pieData in _aryData){
        UIColor *color = pieData.color;
        [color setFill];
        CGContextMoveToPoint(ctx, ptCenter.x, ptCenter.y);
        CGFloat endAngle = startAngle + pieData.val/_total*360*(M_PI/180.0);
        CGContextAddArc(ctx, ptCenter.x, ptCenter.y, radius, startAngle , endAngle, 0);
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        startAngle = endAngle;
    }
}

@end
