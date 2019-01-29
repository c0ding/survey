//
//  UITextField+HJCheck.h
//  thrallplus
//
//  Created by HeJia on 16/7/5.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef bool (^CheckFunc)(UITextField *tf, NSRange range ,NSString *string);
typedef void (^BeginEdit)(UITextField *tf);
typedef void (^EndEdit)(UITextField *tf);

@interface UITextField (HJCheck)<UITextFieldDelegate>


@property (nonatomic,copy) CheckFunc checkFunc;

@property (nonatomic,copy) BeginEdit beginFunc;

@property (nonatomic,copy) EndEdit endFunc;

@end
