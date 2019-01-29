//
//  JYHColor.h
//  CongestionOfGod
//
//  Created by 黄 梦炜 on 15/1/12.
//  Copyright (c) 2015年 黄 梦炜. All rights reserved.
//

#ifndef CongestionOfGod_JYHColor_h
#define CongestionOfGod_JYHColor_h


#endif


/*!
 @discussion 背景色
 */

#define color_mainBlueShdow 0x0436CC
#define color_mainGreenShdow 0x4B8910
#define color_mainYellowShodow 0xB51E20

#define Color_BgBlue 0x4a90e2
#define Color_BgPouple 0x5167E4   //渐变色蓝-紫色
#define Color_BgYelloGreen 0x99D72E
#define Color_BgGreen 0x6BAC56   //渐变黄绿-绿色
#define Color_BgOrange 0xFBA844
#define Color_BgRed 0xF05959   //渐变橙色-红色
#define Color_gifBack 0xF9FAFB  //gif 背景色
#define Color_gifCancle 0x5092FF  //gif 取消
//#define Color_BgOrange 0xf6a623

#define Color_BgLightGray 0xe9e9e9
#define Color_BgGray 0xd8d8d8
#define Color_BgMoreLightGray 0xF9FAFB


//investment
#define Color_investmentBack 0xD8D8D8 
//backMoney
#define Color_backMoney 0x5092FF
//residueBack
#define Color_residueBack 0x7ED321


/*!
 @discussion 字体颜色
 */
#define Color_FontBlue 0x4a90e2
#define COlor_FontGray 0x9b9b9b
#define Color_FontBlack 0x4a4a4a

/*!
 @method getColorP(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result P / 255.0
 */
static inline float getColorP(int intColor){
    return 1.0 - ((intColor & 0xFF000000)>> 0x18) / 255.0f;
}

/*!
 @method getColorR(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result R / 255.0
 */
static inline float getColorR(int intColor){
    return ((intColor & 0x00FF0000) >> 0x10 ) / 255.0f;
}

/*!
 @method getColorG(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result G / 255.0
 */
static inline float getColorG(int intColor) {
    return ((intColor & 0x0000FF00) >> 0x08 ) / 255.0f;
}

/*!
 @method getColorB(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result B / 255.0
 */
static inline float getColorB(int intColor) {
    return (intColor & 0x000000FF) / 255.0f;
}


/*!
 @method getColorP(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result P / 255.0
 */
static inline UIColor* getUIColor(int intColor){
    
    return [UIColor colorWithRed:getColorR(intColor) green:getColorG(intColor) blue:getColorB(intColor) alpha:getColorP(intColor)];
}
