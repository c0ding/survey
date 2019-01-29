//
//  HJUICommon.m
//  thrallplus
//
//  Created by HeJia on 16/6/13.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJUICommon.h"
#import "HJAlertController.h"

@implementation HJUICommon

+(UIImage *)getAutoResizeImage:(UIImage *)img
{
    return [img stretchableImageWithLeftCapWidth:img.size.width/2.0 topCapHeight:img.size.height/2.0];
}

+(UIImage*) getAutoResizeImage:(UIImage *)img x:(int)x y:(int)y
{
    return [img stretchableImageWithLeftCapWidth:x topCapHeight:y];
}

+ (void)shakeView:(UIView *)viewToShake duration:(CGFloat)fDuration completion:(void (^)(BOOL finished))completion
{
    //左右抖动
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    CGFloat freq = 0.07;
    CGFloat repeatCount = (fDuration - 0.05)/0.1;
    
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:freq delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:repeatCount];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:completion];
        }
    }];
}

+(void)hjStyleButton{
    
}

@end



UIColor *colorWithRGB(CGFloat r,CGFloat g,CGFloat b){
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0];
}


UIColor* hexColor(NSInteger hex){
    return hexColorWithAlpha(hex, 1.0);
}

UIColor* hexColorWithAlpha(NSInteger hex , CGFloat alpha){
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0x00FF00) >> 8))/255.0
                            blue:((float)(hex & 0x0000FF))/255.0
                           alpha:alpha];
}



void hjStyleButton(UIButton *btn){
    UIColor *color = Black;
    UIColor *colorDisable = hexColor(0xe6e4e2);
    [btn setTitleColor:hexColor(0xf6f5f2) forState:UIControlStateNormal];
    [btn setTitleColor:hexColor(0xf6f5f2) forState:UIControlStateDisabled];
//    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
//    btn.layer.borderWidth = 1.0f;
    btn.layer.cornerRadius = 2.0f;
    if(btn.isEnabled){
//        btn.layer.borderColor = color.CGColor;
        btn.backgroundColor = color;
    }else{
//        btn.layer.borderColor = colorDisable.CGColor;
        btn.backgroundColor = colorDisable;
    }
    
    [[btn rac_signalForSelector:@selector(setEnabled:)] subscribeNext:^(id x) {
        if(btn.isEnabled){
//            btn.layer.borderColor = color.CGColor;
            btn.backgroundColor = color;
        }else{
//            btn.layer.borderColor = colorDisable.CGColor;
            btn.backgroundColor = colorDisable;
        }
    }];
    
    
    
}

void hjVerfButton(UIButton *btn){
    UIColor *color = Black;
    UIColor *colorDisable = hexColor(0xc8c3be);
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:colorDisable forState:UIControlStateDisabled];
    
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
}




UIButton *hjTextFieldRightCloseButton(ClickFunc func){
    UIButton *btnVerfClear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVerfClear setImage:[UIImage imageNamed:@"wjmm_icon_guanbi"] forState:UIControlStateNormal];
    [btnVerfClear setImage:[UIImage imageNamed:@"login_close_pressed"] forState:UIControlStateHighlighted];
    btnVerfClear.frame = CGRectMake(0, 0, 44, 44);
    btnVerfClear.clickFunc = func;
    
    return btnVerfClear;
}

UIButton *hjLoginTextFieldRightCloseButton(ClickFunc func){
    UIButton *btnVerfClear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVerfClear setImage:[UIImage imageNamed:@"dl_icon_guanbi"] forState:UIControlStateNormal];
//    [btnVerfClear setImage:[UIImage imageNamed:@"login_close_pressed"] forState:UIControlStateHighlighted];
    btnVerfClear.frame = CGRectMake(0, 0, 44, 44);
    btnVerfClear.clickFunc = func;
    
    return btnVerfClear;
}

UIImage *resizeImage(UIImage *origImg,CGSize size){
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [origImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ret;
}

NSString *numToMoneyFormat(long lmoney){
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *strMoney = [formatter stringFromNumber:[NSNumber numberWithLong:lmoney]];
    return strMoney;
}

NSString *numfToMoneyFormat(CGFloat fmoney){
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    [formatter setPositiveFormat:@"###,###,###,###,##0.00;"];
    NSString *strMoney = [formatter stringFromNumber:[NSNumber numberWithFloat:fmoney]];
    return strMoney;
}

UIViewController *getCurrentVC(){
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    nextResponder = appRootVC;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        UIViewController *topVC = appRootVC.presentedViewController;
        while (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        nextResponder = topVC;
    }else{
//        UIView *frontView = [[window subviews] objectAtIndex:0];
//        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        if(result.presentedViewController != nil){
            UIViewController *topVC = result.presentedViewController;
            while (topVC.presentedViewController) {
                topVC = topVC.presentedViewController;
            }
            result = topVC;
        }
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

#pragma mark==获取最上存控制器
UIViewController *topViewControllerWithRootViewController(UIViewController * rootViewController){
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return topViewControllerWithRootViewController(tabBarController.selectedViewController);
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return topViewControllerWithRootViewController(navigationController.visibleViewController);
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return topViewControllerWithRootViewController(presentedViewController);
    } else {
        return rootViewController;
    }
    return nil;
}
UIViewController *topViewController(){
    return  topViewControllerWithRootViewController([[UIApplication sharedApplication] keyWindow].rootViewController);
}


void showAlert(NSString *strTitle,NSString *msg){
    if ([getCurrentVC() isKindOfClass:[HJAlertController class]]) {
        return;
    }
    HJAlertController *alert = [HJAlertController alertControllerWithTitle:strTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [getCurrentVC() presentViewController:alert animated:YES completion:nil];
}

NSString *distanceTimeWithBeforeTime(NSTimeInterval beTime)
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

NSString *weekDayWithData(NSInteger dayNum)
{
    NSDate*nowDate = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy.MM.dd"];
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    NSDate* inputDate = [nowDate initWithTimeIntervalSinceNow:oneDay * dayNum];
    
    NSString * dateString = [inputFormatter stringFromDate:inputDate];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitWeekday fromDate:inputDate];
    
    NSInteger weekDay = dateComps.weekday;
    NSString *week = @"";
    
    switch (weekDay) {
        case 1:
            week = @"星期日";
            break;
        case 2:
            week =  @"星期一";
            break;
        case 3:
            week =  @"星期二";
            break;
        case 4:
            week =  @"星期三";
            break;
        case 5:
            week =  @"星期四";
            break;
        case 6:
            week =  @"星期五";
            break;
        case 7:
            week =  @"星期六";
            break;
        default:
            week =  @"";
            break;
    }
    
    return  [NSString stringWithFormat:@"%@(%@)",dateString,week];
}

NSString *ratioFormat(CGFloat ratio){
    return [NSString stringWithFormat:@"%@%%",ratioFormatWithoutPercent(ratio)];
}

NSString *ratioFormatWithoutPercent(CGFloat ratio){
    long tmp = round(ratio *100 * 100);
    if(tmp % 10 == 0){
        return [NSString stringWithFormat:@"%.1f",ratio * 100];
    }else{
        return [NSString stringWithFormat:@"%.2f",ratio * 100];
    }
}

NSString*  removeEmoji(NSString *username){
    
    NSString *regex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *temp = nil;
    
    for(int i = 0; i < [username length]; i++)
    {
        temp = [username substringWithRange:NSMakeRange(i, 1)];
        if ([predicate evaluateWithObject:temp]) {
            
        } else {
            NSRange range = NSMakeRange(i, 1);
            username = [username stringByReplacingCharactersInRange:range withString:@" "];
        }
    }
    
    NSString *withoutEmojiUsername = [username stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return withoutEmojiUsername;
}

UIAlertController* showTip(NSString *tip,completion callBack){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:tip preferredStyle:UIAlertControllerStyleAlert];
    [getCurrentVC() presentViewController:alert animated:NO completion:callBack];
    return alert;
}


void hideTip(completion callBack){
    UIViewController *vc = getCurrentVC();
    if([vc isKindOfClass:[UIAlertController class]]){
        [vc dismissViewControllerAnimated:NO completion:callBack];
    }
}

UIImage* blurryImage(UIImage *image ,CGFloat blur){
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

UIImage* capture(){
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGContextRelease(UIGraphicsGetCurrentContext());
    
    return viewImage;
}
CGSize txtSize(NSString * txt,UIFont *font,CGSize maxSize){
    return [txt boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

