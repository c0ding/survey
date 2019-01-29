//
//  ZZProgressView.h
//  MyProject
//
//  Created by 祝小夏 on 2017/5/2.
//  Copyright © 2017年 Tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZProgressView;
@protocol ZZProgressViewDelegate <NSObject>
@optional
- (void)slider:(ZZProgressView*)sender ValueChanged:(float)value;

@end

@interface ZZProgressView : UIView
@property (nonatomic, weak) id<ZZProgressViewDelegate> delegate;
@property (nonatomic, assign) float value;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIColor *leftValueTintColor;
@property (nonatomic, strong) UIColor *rightValueTintColor;

@end
