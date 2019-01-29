//
//  UITextField+HJCheck.m
//  thrallplus
//
//  Created by HeJia on 16/7/5.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "UITextField+HJCheck.h"
#import <objc/runtime.h>

#define TF_CHECKFUNC "_tf_checkfunc"
#define TF_BEGINFUNC "_tf_beginfunc"
#define TF_ENDFUNC "_tf_endfunc"

@implementation UITextField (HJCheck)
@dynamic checkFunc;
@dynamic beginFunc;
@dynamic endFunc;

-(void) setCheckFunc:(CheckFunc)checkFunc{
    if(self.delegate != self) self.delegate = self;
    
    objc_setAssociatedObject(self, TF_CHECKFUNC, checkFunc, OBJC_ASSOCIATION_COPY);
}

-(CheckFunc) checkFunc{
    return objc_getAssociatedObject(self, TF_CHECKFUNC);
}

-(void) setBeginFunc:(BeginEdit)beginFunc{
    if(self.delegate != self) self.delegate = self;
    
    objc_setAssociatedObject(self, TF_BEGINFUNC, beginFunc, OBJC_ASSOCIATION_COPY);
}

-(BeginEdit) beginFunc{
    return objc_getAssociatedObject(self, TF_BEGINFUNC);
}

-(void) setEndFunc:(EndEdit)endFunc{
    if(self.delegate != self) self.delegate = self;
    
    objc_setAssociatedObject(self, TF_ENDFUNC, endFunc, OBJC_ASSOCIATION_COPY);
}

-(EndEdit) endFunc{
    return objc_getAssociatedObject(self, TF_ENDFUNC);
}

-(bool) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(self.checkFunc) return self.checkFunc(textField,range,string);
    else return TRUE;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    if(self.beginFunc) self.beginFunc(textField);
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    if(self.endFunc) self.endFunc(textField);
}


@end
