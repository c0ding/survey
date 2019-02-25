//
//  NSString+Extension.h

#import <Foundation/Foundation.h>

@interface NSString (Extension)

// 手机号码校验
- (BOOL)isPhoneNumber;

// 密码校验
- (BOOL)isPSW;

// 用户名校验
- (BOOL)isUsername;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/// 四舍五入
+(NSString *)notRounding:(double)price afterPoint:(int)position;
/// 转换成万元
+ (NSString *)moneyFormatterWanYuanWithValue:(double )value;

/// 转换成元
+ (NSString *)moneyFormatterYuanWithValue:(double )value;

///转换成 % 格式
+ (NSString *)convertedToAbsolutelyWithValue:(double )value;



///转换成 % 格式 整数
+ (NSString *)convertedToAbsolutelyIntWithValue:(double )value;
///时间戳转换为时间日
+ (NSString *)timeWithTimeIntervalStringHavedd:(long long )timeString;

///时间戳转换为时间月日
+ (NSString *)timeWithTimeIntervalStringHaveMMdd:(long long )timeString;

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMddTypeTwo:(long long )timeString;
///时间戳转换为时间年月日
+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMdd:(long long )timeString;

+ (NSString *)timeWithTimeIntervalStringHavehh;

+ (NSString *)timeWithTimeIntervalStringHaveMMDDChina:(long long )timeString;
///时间戳转换为时间xx月
+ (NSString *)timeWithTimeIntervalStringHaveMMChina:(long long )timeString;
///时间戳转换为时间xx年xx月
+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMChina:(long long )timeString;

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChina:(long long )timeString;

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChinaIfThisYear:(long long )timeString;

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChinaIfThisYearLowYear:(long long )timeString;
@end
