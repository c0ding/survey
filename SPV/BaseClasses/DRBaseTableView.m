//
//  DRBaseTableView.m
//  SPV
//
//  Created by 张逸阳 on 2017/12/6.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRBaseTableView.h"

@implementation DRBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
//            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//            self.scrollIndicatorInsets = self.contentInset;
//        }
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
       
        }else {
           
            
        }
        
    }
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
