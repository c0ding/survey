//
//  NSMutableAttributedString+DREX.h
//  SPV
//
//  Created by 张逸阳 on 2017/12/28.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DREX)
+ (NSMutableAttributedString*)lastStrFontWithStr:(NSString *)str andFontsize:(CGFloat)fontSize andLastFontSize:(CGFloat)lastFontSize;
@end
