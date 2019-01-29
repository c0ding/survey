//
//  PieCharModel.m
//  PieChar
//
//  Created by 许文波 on 15/12/25.
//  Copyright © 2015年 afanti. All rights reserved.
//

#import "PieCharModel.h"

@implementation PieCharModel
+(PieCharModel *)create:(NSString *)percent color:(UIColor *)col andTitle:(NSString *)title
{
    PieCharModel *model=[PieCharModel new];
    model.color=col;
    model.title=title;
    model.percent=percent;
    return model;
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
