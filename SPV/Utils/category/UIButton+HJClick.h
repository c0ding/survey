//
//  UIButton+HJClick.h
//  thrallplus
//
//  Created by HeJia on 16/7/6.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickFunc)(id sender);
@interface UIButton (HJClick)

@property (nonatomic,copy) ClickFunc clickFunc;

@end
