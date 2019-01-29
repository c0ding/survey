//
//  HJPieView.h
//  thrallplus
//
//  Created by HeJia on 16/8/9.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPieDataStruct : NSObject

@property (nonatomic,assign) CGFloat val;
@property (nonatomic,strong) UIColor *color;

+(HJPieDataStruct *) create:(CGFloat) val color:(UIColor *)col;

@end

@interface HJPieView : UIView
@property(nonatomic,assign)BOOL showText;
@property (nonatomic,strong) NSArray<HJPieDataStruct *> *aryData;

@end
