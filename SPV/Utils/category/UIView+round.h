//
//  UIVew+round.h
//  SPV
//
//  Created by hejiahuan on 2017/3/15.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//


typedef  NS_ENUM(NSInteger, SMBSide){
    kSMBSideLeft=0,
    kSMBSideRight,
    kSMBSideUp,
};
@interface UIView (round)
- (void)roundSide:(SMBSide)side;
@end
