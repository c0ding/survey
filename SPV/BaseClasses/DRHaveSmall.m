//
//  DRHaveSmall.m
//  SPV
//
//  Created by 黄梦炜 on 2017/12/8.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRHaveSmall.h"

@implementation DRHaveSmall

-(void)TextWithString:(NSString *)string
{
    if (string) {
        NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:string];
        if (string.length > 1) {
            NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:@"."].location, string.length - [[noteStr string] rangeOfString:@"."].location );
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:redRangeTwo];
        }
        [self setAttributedText:noteStr];
    }
    
    
}

-(void)setTextWithString:(NSString *)string withLength:(NSInteger)length
{
    if (string) {
        NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:string];
        NSRange redRangeTwo = NSMakeRange(string.length - length, length );
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:redRangeTwo];
        [self setAttributedText:noteStr];
    }
    
}

-(void)setTextBeforeColor:(NSString *)string withColor:(UIColor *)color
{
    if (string) {
        NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:string];
        NSRange redRangeTwo = NSMakeRange(0,[[noteStr string] rangeOfString:@"/"].location);
        [noteStr addAttribute:NSForegroundColorAttributeName value:color range:redRangeTwo];
        [self setAttributedText:noteStr];
    }
    
}

-(void)TextWithStringFont:(NSString *)string withFont:(UIFont *)font
{
    if (string) {
        NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:string];
        NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:@"."].location, string.length - [[noteStr string] rangeOfString:@"."].location );
        [noteStr addAttribute:NSFontAttributeName value:font range:redRangeTwo];
        [self setAttributedText:noteStr];
    }
    
    
}


@end
