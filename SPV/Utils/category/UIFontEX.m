//
//  UIFontEX.m
//

#import "UIFontEX.h"

// 应用字体的Font Name
#define kApplicationFontName @"PingFangSC-Light"
#define kBoldApplicationFontName @"PingFangSC-Medium"
#define kRegulerApplicationFontName @"PingFangSC-Regular"

typedef enum {
    HYApplicationFontUnknown,
    HYApplicationFontFound,
    HYApplicationFontNotFound
} HYApplicationFontIsFound;

// 应用自带的字体是否存在
static HYApplicationFontIsFound sApplicationRegularFontExist = HYApplicationFontUnknown;
static HYApplicationFontIsFound sApplicationBoldFontExist = HYApplicationFontUnknown;


@implementation UIFont (EX)

- (CGFloat)rowHeight{
    
    
    float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];

    CGFloat rowH = sysVersion < 4.0?self.leading:self.lineHeight;
    return  rowH;
}

- (CGSize)sizeWithText:(NSString *)text maxWidth:(CGFloat)mWidth
{
    CGSize constrainedSize = CGSizeMake(mWidth, INT_MAX);
    CGSize textSize = [text sizeWithFont:self constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByCharWrapping];
    return textSize;
}

+ (UIFont *)LightapplicationFontOfSize:(CGFloat)size;
{
    // 判断 static 变量中存储的 字体查找结果
    if (sApplicationRegularFontExist == HYApplicationFontNotFound) {
        return [UIFont systemFontOfSize:size];
    } else if (sApplicationRegularFontExist == HYApplicationFontFound) {
        return [UIFont fontWithName:kApplicationFontName size:size];
    } else {
        UIFont* gotFont = [UIFont fontWithName:kApplicationFontName size:size];
        // 取到的字体是否是define的字体名称对应的字体
        if (gotFont && ([gotFont.fontName compare:kApplicationFontName] == NSOrderedSame || [gotFont.familyName compare:kApplicationFontName] == NSOrderedSame)) {
            sApplicationRegularFontExist = HYApplicationFontFound;
            return gotFont;
        }
    }

    sApplicationRegularFontExist = HYApplicationFontNotFound;
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldApplicationFontOfSize:(CGFloat)size
{
    // 判断 static 变量中存储的 字体查找结果
    if (sApplicationBoldFontExist == HYApplicationFontNotFound) {
        return [UIFont boldSystemFontOfSize:size];
    } else if (sApplicationBoldFontExist == HYApplicationFontFound) {
        return [UIFont fontWithName:kBoldApplicationFontName size:size];
    } else {
        UIFont* gotFont = [UIFont fontWithName:kBoldApplicationFontName size:size];
        // 取到的字体是否是define的字体名称对应的字体
        if (gotFont && ([gotFont.fontName compare:kBoldApplicationFontName] == NSOrderedSame || [gotFont.familyName compare:kBoldApplicationFontName] == NSOrderedSame)) {
            sApplicationBoldFontExist = HYApplicationFontFound;
            return gotFont;
        }
    }

    sApplicationBoldFontExist = HYApplicationFontNotFound;
    return [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)regulerApplicationFontOfSize:(CGFloat)size
{
    // 判断 static 变量中存储的 字体查找结果
    if (sApplicationBoldFontExist == HYApplicationFontNotFound) {
        return [UIFont boldSystemFontOfSize:size];
    } else if (sApplicationBoldFontExist == HYApplicationFontFound) {
        return [UIFont fontWithName:kRegulerApplicationFontName size:size];
    } else {
        UIFont* gotFont = [UIFont fontWithName:kRegulerApplicationFontName size:size];
        // 取到的字体是否是define的字体名称对应的字体
        if (gotFont && ([gotFont.fontName compare:kRegulerApplicationFontName] == NSOrderedSame || [gotFont.familyName compare:kRegulerApplicationFontName] == NSOrderedSame)) {
            sApplicationBoldFontExist = HYApplicationFontFound;
            return gotFont;
        }
    }
    
    sApplicationBoldFontExist = HYApplicationFontNotFound;
    return [UIFont boldSystemFontOfSize:size];
}

@end
