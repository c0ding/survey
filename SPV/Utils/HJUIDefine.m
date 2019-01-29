//
//  HJUIDefine.m
//  thrallplus
//
//  Created by hxt on 16/9/9.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJUIDefine.h"

@implementation HJUIDefine


NSAttributedString *numToChangeFont(NSString *string,NSUInteger len1, NSUInteger len2, CGFloat fontSize) {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Uni-Sans-Book" size:fontSize] range:NSMakeRange(len1,string.length - len1 - len2)];
    return attStr;
}

NSAttributedString *numToChangeColor(NSString *string,NSUInteger len1, NSUInteger len2, UIColor *color) {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(len1,string.length - len1 - len2)];
    return attStr;
}


NSString *mobileStyle(NSString *mobile)
{
    
    NSMutableString *string = [[NSMutableString alloc]initWithString:mobile];
    if ([string length] >= 3) {
        [string insertString:@" " atIndex:3];
    }
    if ([string length] >= 8) {
        [string insertString:@" " atIndex:8];
    }
    return (NSString *)string;
}





@end
