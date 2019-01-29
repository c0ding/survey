//
//  UIFont+UIFontEX.h
//

#import <UIKit/UIKit.h>

@interface UIFont (EX)

- (CGFloat)rowHeight;
- (CGSize)sizeWithText:(NSString *)text maxWidth:(CGFloat)mWidth;

/*!
 扩展原有的systemFontOfSize，来应用我们自己制定的字体
*/
+ (UIFont *)LightapplicationFontOfSize:(CGFloat)size;

/*!
 扩展原有的boldSystemFontOfSize，来应用我们自己制定的字体
 */
+ (UIFont *)boldApplicationFontOfSize:(CGFloat)size;

+ (UIFont *)regulerApplicationFontOfSize:(CGFloat)size;
@end
