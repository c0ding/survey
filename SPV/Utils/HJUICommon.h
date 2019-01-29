//
//  HJUICommon.h
//  thrallplus
//
//  Created by HeJia on 16/6/13.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+HJClick.h"

@interface HJUICommon : NSObject

+(UIImage*) getAutoResizeImage:(UIImage*) img;

+(UIImage*) getAutoResizeImage:(UIImage*) img x:(int)x y:(int)y;

+ (void)shakeView:(UIView *)viewToShake duration:(CGFloat)fDuration completion:(void (^)(BOOL finished))completion;

@end


extern CGSize txtSize(NSString * txt,UIFont *font,CGSize maxSize);

extern UIColor *colorWithRGB(CGFloat r,CGFloat g,CGFloat b);

extern UIColor* hexColor(NSInteger hex);

extern UIColor* hexColorWithAlpha(NSInteger hex, CGFloat alpha);

extern void hjStyleButton(UIButton *btn);

extern void hjVerfButton(UIButton *btn);

extern UIButton *hjTextFieldRightCloseButton(ClickFunc func);

extern UIButton *hjLoginTextFieldRightCloseButton(ClickFunc func);

extern UIImage *resizeImage(UIImage *origImg,CGSize size);

extern NSString *numToMoneyFormat(long lmoney);

extern NSString *numfToMoneyFormat(CGFloat fmoney);

extern UIViewController *getCurrentVC();
extern UIViewController *topViewController();
extern void showAlert(NSString *title,NSString *msg);

typedef void(^completion)(void);

extern UIAlertController* showTip(NSString *tip,completion callBack);

extern void hideTip(completion callBack);

extern NSString *weekDayWithData(NSInteger dayNum);

extern NSString *distanceTimeWithBeforeTime(NSTimeInterval beTime);

extern NSString *ratioFormatWithoutPercent(CGFloat ratio);

extern NSString *ratioFormat(CGFloat ratio);

extern NSString*  removeEmoji(NSString *username);

extern UIImage* blurryImage(UIImage *image ,CGFloat blur);

extern UIImage* capture();
