//
//  DRDatePicker.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/20.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Ex.h"
#import "NSDate+Search.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^DateChooseCallBack)(NSString *date);
@interface DRDatePicker : UIView
@property (copy, nonatomic) DateChooseCallBack dateChooseCallBack;

@property (strong, nonatomic) NSString *title;
- (void)show ;
- (void)dismiss ;
@end

NS_ASSUME_NONNULL_END
