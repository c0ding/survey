//
//  NSMutableAttributedString+DREX.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/28.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "NSMutableAttributedString+DREX.h"

@implementation NSMutableAttributedString (DREX)
+ (NSMutableAttributedString*)lastStrFontWithStr:(NSString *)str andFontsize:(CGFloat)fontSize andLastFontSize:(CGFloat)lastFontSize {
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:str];
    //
    [centerText addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:fontSize],
                                NSForegroundColorAttributeName: RGB(74, 74, 74)
                                } range: NSMakeRange(0, str.length-1)];
    
    [centerText addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:lastFontSize],
                                NSForegroundColorAttributeName: RGB(155, 155, 155)
                                } range: NSMakeRange(str.length-1, 1)];
    
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    //对齐方式
    paragraph.alignment = NSTextAlignmentCenter;
    [centerText addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, centerText.length)];
    return centerText;
}
@end



