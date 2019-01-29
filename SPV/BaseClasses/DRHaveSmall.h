//
//  DRHaveSmall.h
//  SPV
//
//  Created by 黄梦炜 on 2017/12/8.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRHaveSmall : UILabel

-(void)TextWithString:(NSString *)string;

-(void)setTextWithString:(NSString *)string withLength:(NSInteger)length;

-(void)setTextBeforeColor:(NSString *)string withColor:(UIColor *)color;

-(void)TextWithStringFont:(NSString *)string withFont:(UIFont *)font;

@end
