//
//  UIButton+HJClick.m
//  thrallplus
//
//  Created by HeJia on 16/7/6.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "UIButton+HJClick.h"
#import <objc/runtime.h>

#define BTN_CLICKFUNC "_btnClickFunc"

@implementation UIButton (HJClick)
@dynamic clickFunc;

-(void) setClickFunc:(ClickFunc)clickFunc
{
    objc_setAssociatedObject(self, BTN_CLICKFUNC, clickFunc, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(ClickFunc) clickFunc{
    return objc_getAssociatedObject(self, BTN_CLICKFUNC);
}

-(void) onClick:(id) sender{
    self.clickFunc(sender);
}

@end
