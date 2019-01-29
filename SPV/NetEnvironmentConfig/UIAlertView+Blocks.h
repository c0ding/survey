//
//  UIAlertView+Blocks.h
//  SPV
//
//  Created by 张逸阳 on 2017/7/12.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIAlertView (Blocks)

-(id)lh_initWithTitle:(NSString *)inTitle
           message:(NSString *)inMessage
  cancelButtonItem:(RIButtonItem *)inCancelButtonItem
  otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)lh_addButtonItem:(RIButtonItem *)item;

@end
