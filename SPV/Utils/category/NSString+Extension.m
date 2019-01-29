//
//  NSString+Extension.m


#import "NSString+Extension.h"

@implementation NSString (Extension)
- (BOOL)match:(NSString *)pattern {
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}


- (BOOL)isPhoneNumber {
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1\\d{10}$"];
    //    return [self match:@"^(13\\d|14[57]|15[^4,\\D]|17[678]|18\\d)\\d{8}$|^170[059]\\d{7}$"];
}



- (BOOL)isUsername {
    // 用户名规则：2-20位字符，支持英文、数字；
    return [self match:@"^[A-Za-z0-9]{2,20}$"];
}

- (BOOL)isPSW {
    //密码规则：6-20位字母数字组合，字母需区分大小写，允许输入半角标点，不允许空格；
    return [self match:@"^[A-Za-z0-9`!@#$%^&*()_=+{}|\\:\";',./<>?x22]{6,20}$"];
}
#pragma mark 计算字符串大小
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

//四舍五入
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    
    price = price * 100;
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSString *)moneyFormatterWanYuanWithValue:(double )value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    // 小数位最多位数
    formatter.maximumFractionDigits = 2;
    
    if (value == 0) {
        formatter.minimumFractionDigits = 2;// 小数位最少位数。为0时展示0.00
    }
    else{
        formatter.minimumFractionDigits = 2;
    }
    
    return [formatter stringFromNumber:[NSNumber numberWithDouble:value*0.0001]];
}

+ (NSString *)timeWithTimeIntervalStringHavedd:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveMMdd:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMdd:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSString *)timeWithTimeIntervalStringHaveMMChina:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveMMDDChina:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMChina:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChina:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSString *)convertedToAbsolutelyWithValue:(double )value
{
     return  [NSString stringWithFormat:@"%.0lf%%",value*100];
}

+ (NSString *)convertedToAbsolutelyIntWithValue:(double )value
{
    return  [NSString stringWithFormat:@"%.0f%%",value*100];
}

+ (NSString *)moneyFormatterYuanWithValue:(double )value
{
 
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    
    formatter.maximumFractionDigits = 0;
    
    formatter.minimumFractionDigits = 0;
    
    return [formatter stringFromNumber:[NSNumber numberWithDouble:round(value)]];
}

+ (NSString *)timeWithTimeIntervalStringHavehh    //问候类型
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"HH"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate date];
    NSString* dateString = [formatter stringFromDate:date];
    
    /**
     早上好  （5:00-11:00]
     中午好   (11:00-14:00]
     下午好   (14:00-17:00]
     晚上好   (17:00-24:00]
     夜深了   (00：00-5:00]
     */
    
    NSString *helloString;
    if ([dateString integerValue] >= 5 && [dateString integerValue] < 11) {
        helloString = @"早上好！";
    } else if ([dateString integerValue] >= 11 && [dateString integerValue] < 14)
    {
        helloString = @"中午好！";
    } else if([dateString integerValue] >= 14 && [dateString integerValue] < 17)
    {
        helloString = @"下午好！";
    } else if([dateString integerValue] >= 17 && [dateString integerValue] < 24)
    {
        helloString = @"晚上好！";
    } else if([dateString integerValue] >= 0 && [dateString integerValue] <= 5)
    {
        helloString = @"夜深了…";
    }
    return helloString;
}


+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChinaIfThisYear:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    if (date.isThisYear) {
        [formatter setDateFormat:@"MM月dd日"];
    } else {
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringHaveYYYYMMDDChinaIfThisYearLowYear:(long long )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString / 1000.0];
    if (date.isThisYear) {
        [formatter setDateFormat:@"MM月dd日"];
    } else {
        [formatter setDateFormat:@"MM月dd日\nyyyy年"];
    }
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
