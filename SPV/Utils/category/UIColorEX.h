//
//  UIColorEX.h
//

#import <Foundation/Foundation.h>
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB(r, g, b) RGBA(r, g, b, 1)
/*!
 *  @brief UIColor component interface
 */
@interface UIAColorComponents: NSObject

//! @brief Red component
@property(nonatomic,readonly) CGFloat red;
//! @brief Green component
@property(nonatomic,readonly) CGFloat green;
//! @brief Blue component
@property(nonatomic,readonly) CGFloat blue;
//! @brief Alpha component
@property(nonatomic,readonly) CGFloat alpha;

/*!
 *  @brief Initialize color components from color
 *  @param color
 *      An UIColor
 */
- (id)initWithColor:(UIColor *)color;
/*!
 *  @brief Creates and returns color components from color
 *  @see initWithColor:
 */
+ (id)componentsWithColor:(UIColor *)color;

@end

@interface UIColor (EX)

/*!
 *  @brief Color component property. nil if unavailable.
 */
@property(nonatomic,readonly) UIAColorComponents *components;

#ifndef PLUGIN_FOR_TAOBAO
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha;
#endif

+ (UIColor *)tm_colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha;
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

/*!
 *  @param string "aarrggbb" or "#aarrggbb" or "rrggbb" or "#rrggbb"
 */
+ (UIColor *)colorWithString:(NSString *)string;

/*!
 *  @brief Colored image sized as given size.
 *  @param size The image size to create.
 */
- (UIImage *)imageOfSize:(CGSize)size;

/*!
 *  @brief Colored image sized 1x1
 */
- (UIImage *)image;

- (UIColor *)colorWithAlpha:(CGFloat)alpha;

- (UIColor *)mixedColorWithColor:(UIColor *)color ratio:(CGFloat)ratio;

- (UIColor *)highligtedColorForBackgroundColor:(UIColor *)backgroundColor;

- (UIColor *)highligtedColor;

@end
