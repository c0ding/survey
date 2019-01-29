//
//  UIButton+UIButtonEX.m
//  QIAO
//
//  Created by codi on 17/2/23.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "UIButton+UIButtonEX.h"

@implementation UIButton (UIButtonEX)
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
 CGSize textSize =  [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(30, 30)];
//    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
@end
