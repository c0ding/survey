//
//  ColorView.h
//  btn
//
//  Created by 张逸阳 on 2017/12/20.
//  Copyright © 2017年 LYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {
    topToBottomView = 0,//从上到小
    leftToRightView = 1,//从左到右
    upleftTolowRightView = 2,//左上到右下
    uprightTolowLeftView  = 3,//右上到左下
}GradientViewType;
@interface ColorView : UIView
- (id)initWithFrame:(CGRect)frame FromColorArray:(NSMutableArray*)colorArray ByGradientType:(GradientViewType)gradientType;
@end
