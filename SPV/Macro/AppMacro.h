//
//  AppMacro.h
//  QIAO
//
//  Created by codi on 17/2/8.
//  Copyright © 2017年 zyy. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#import "MBManager.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"
#import "UIFontEX.h"
#import "NSString+Extension.h"
#import "UIColorEX.h"
#import "UIView+FMKit.h"
#import "FCUUID.h"
#import "AFNetworking.h"
#import "UIApplication+ZZAdd.h"
#import <MBProgressHUD.h>
#import "MBProgressHUD+MP.h"
#import <Masonry.h>
#import "SPV-Bridging-Header.h"
#import "MJExtension.h"
#import "UIBarButtonItem+Extension.h"
#import "LGAlertView.h"
#import "DRBaseViewController.h"
#import "UIButton+UIButtonEX.h"
#import "UIImageView+WebCache.h"
#import "request.h"
#import "UITableView+HYBCacheHeight.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>
#import "DRBaseTableView.h"
#import <iCarousel.h>
#import "DRHaveSmall.h"
#import "DRBaseModel.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UICountingLabel.h"
#import "NSMutableAttributedString+DREX.h"
#import "NSDate+DRExtension.h"



//#define BaseUrl          @"http://192.168.2.213:8080/" //开发
//#define BaseUrl         @"http://120.55.85.150:10021/laolaiqiao-web/"//测试


/*--------------------背景色--------------------*/
#define DR_BGCOR1 [UIColor colorWithString:@"#1f90e7"] //蓝色
#define DR_BGCOR2 [UIColor colorWithString:@"#e9f8ff"] //首页按钮选中时的蓝色
#define DR_BGCOR3 [UIColor colorWithString:@"#f5f5f5"] //浅灰色

#define DR_LIST_SELECTED 0xf7f7f7

/*--------------------文字色、图片色--------------------*/
/**蓝色*/
#define DR_COR1 [UIColor colorWithString:@"#1f90e7"]
/**灰色*/
#define DR_COR2 [UIColor colorWithString:@"#999999"]
/**黄色*/
#define DR_COR3 [UIColor colorWithString:@"#f79c27"]
/**深蓝色*/
#define DR_COR4 [UIColor colorWithString:@"#005b9a"]
/**绿色*/
#define DR_COR5 [UIColor colorWithString:@"#8fc31f"]




/*--------------------分割线颜色--------------------*/
#define RF_LINECOR1 0xd9d9d9

/*--------------------字体大小--------------------*/
#define DR_SIZE1 60

/*--------------------数值--------------------*/


#define Count(R) (iPhone10?((R)*(kScreenHeight)/667):iPhone4?((R)*(kScreenHeight)/568):((R)*(kScreenHeight)/667))

#define LogAB(a,b) (log(b) / log(a))

#define kToAppStoreUrl @"itms-apps://itunes.apple.com/cn/app/zhi-neng-jian-ce-xi-tong/id1356009359?l=zh&ls=1&mt=8"

///非强更新的版本提示，记录过，就不再提示
#define kUpdateDidPop @"didPop"
///验证码重测时间
#define kVerifyCodeBtnTimeFail 60

#define kPwdError @"601"
#define kPhoneNoFind @"602"
#define kPhoneRepeatede @"604"
#define kSuccess @"200"
#define kNoogin @"600"
#define kUsernameNoFind @"611"
//STATUS_200("200", "OK"),
//STATUS_300("300", "参数不能为空"),
//STATUS_400("400", "失败"),
//STATUS_500("500", "Exception"),
//STATUS_600("600", "请先登录"),
//STATUS_601("601", "用户名或密码错误，请重新输入"),
//STATUS_602("602", "手机号不存在"),
//STATUS_604("604", "手机号已注册"),
//STATUS_605("605", "验证码错误"),
//STATUS_606("606", "验证码不存在或已失效"),
//STATUS_607("607", "邀请码不存在"),
//STATUS_608("608", "邀请码已使用"),
//STATUS_609("609", "昵称已存在"),
//STATUS_610("610", "请输入六位数字验证码"),
//STATUS_611("611", "该用户名未注册，请使用邀请码注册"),
//STATUS_1070("1070", "未找到数据");
//STATUS_1070("1070", "未找到数据");

//日志输出管理
#ifdef DEBUG
#define DRLog(...) NSLog(@"%s 第%d行\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define RFLog(...)
#endif

#endif /* AppMacro_h */
