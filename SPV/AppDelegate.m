
//
//  AppDelegate.m
//  SPV
//
//  Created by hejiahuan on 2017/2/28.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "AppDelegate.h"
#import "HJDataInterface.h"
#import <IQKeyboardManager.h>
#import "LoginVC.h"
#import "MJExtension.h"

#import "DRProfileHomeViewController.h"
#import "ZYSliderViewController.h"

#import "XTGuidePagesViewController.h"


#import "DRHomeVC.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate,selectDelegate>
@property (nonatomic) BOOL isLaunchedByNotification;//标识用户是否通过点击通知消息进入本应用。
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //清空版本提示记录
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUpdateDidPop];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [NSThread sleepForTimeInterval:2];
    
    initDM(@{
             @"osVersion":[UIDevice currentDevice].systemVersion?:@"",
             @"version":appVersion()?:@"",
             @"os":@"iOS",
             @"userKey":(__userData != nil ? __userData.userKey?:@"" :@"")
             }, [NSSet setWithObjects:@"userKey",@"osVersion",@"version",@"os",nil]);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [AMapServices sharedServices].apiKey = @"9ba11733fc4009bce1d1cfc8d31ec8c0";
    
    //Set xunfei  APPID

    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    
    
    
    //---------设置引导页----------------//
//    NSArray *images = @[@"", @"",@"",@""];
    NSArray *images = @[@"GuidePage_1", @"GuidePage_2",@"GuidePage_3",@"GuidePage_4"];
    NSArray *imageIphoneXs = @[@"GuidePage_1x", @"GuidePage_2x",@"GuidePage_3x",@"GuidePage_4x"];
    BOOL isShowGuidePage = [XTGuidePagesViewController isShow];
//    isShowGuidePage = YES;
    if (isShowGuidePage) {
        XTGuidePagesViewController *xt = [[XTGuidePagesViewController alloc] init];
        self.window.rootViewController = xt;
        xt.delegate = self;
        if (KIsiPhoneX) {
            [xt guidePageControllerWithImages:imageIphoneXs];
        }else {
            [xt guidePageControllerWithImages:images];
        }
        
    }else{
        [self clickEnter];
    }

    [self.window makeKeyAndVisible];
    
    
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 150;//输入框到键盘的距离，默认为10
    [IQKeyboardManager sharedManager].preventShowingBottomBlankSpace = NO; //防止上滑过渡，离得太远
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];


    
    //    NSDictionary *navTitleArr =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:font(17)],UITextAttributeFont,nil];
    //    [[UINavigationBar appearance] setTitleTextAttributes:navTitleArr];
    //设置通知
    //    [self setupNotificationSettingsWithOptions:launchOptions];
    //    [UMConfigure initWithAppkey:@"5a94b8e18f4a9d4934000099" channel:@"App Store"];
    //    [self configUSharePlatforms];
    //    [self confitUShareSettings];
    
    return YES;
}


- (void)clickEnter {
    
    LoginVC *loginVC = [[LoginVC alloc] init];
    DRHomeVC *homeVC = [[DRHomeVC alloc] init];
    DRBaseNavigationViewController *baseNav = [[DRBaseNavigationViewController alloc] initWithRootViewController:homeVC];
    
    self.window.rootViewController = baseNav;
    
}



// UShare
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxce07d2bf07803888" appSecret:@"3a79d9cf1441c470974968fbd379c7a" redirectURL:nil];
   
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107697439"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    
    
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [self postNotiMessageWithUserInfo:userInfo];
    [UMessage setAutoAlert:NO];
    // 当应用在前台时，不推送
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //关闭对话框
        [UMessage setAutoAlert:NO];
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        [UMessage setAutoAlert:NO];
        [self incomePushMessage:userInfo];
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    else {
        [UMessage setAutoAlert:NO];
        [self incomePushMessage:userInfo];
        [UMessage didReceiveRemoteNotification:userInfo];
    }
}



// 处理通知消息进行页面跳转
- (void)incomePushMessage:(NSDictionary *)userInfo
{
//    if ( [UIApplication sharedApplication].applicationIconBadgeNumber >0) {
//        [UIApplication sharedApplication].applicationIconBadgeNumber-=1;
//    }
//
//    DRMessageFromPushModel *model =  [DRMessageFromPushModel mj_objectWithKeyValues:userInfo];
//    DRRealHomeViewController *nav = [[DRRealHomeViewController alloc]init];
//    DRBaseNavigationViewController *baseNav = [[DRBaseNavigationViewController alloc] initWithRootViewController:nav];
//    DRProfileHomeViewController *profile = [[DRProfileHomeViewController alloc] init];
//    DRBaseNavigationViewController *baseprofile = [[DRBaseNavigationViewController alloc] initWithRootViewController:profile];
//    ZYSliderViewController *sliderVC = [[ZYSliderViewController alloc] initWithMainViewController:baseNav leftViewController:baseprofile rightViewController:nil];
//    self.window.rootViewController = sliderVC;
//
//    if ([model.typeInfo isEqualToString:@"a"]  ) {
//        DRCreditorSpendViewController *nextVC = [[DRCreditorSpendViewController alloc] init];
//        nextVC.debetId = model.debetId;
//        nextVC.assetPackageId = model.debetId;
//        [nav.navigationController pushViewController:nextVC animated:YES];
//    } else if ([model.typeInfo isEqualToString:@"b"]) {
//        DRCreditorBackViewController *nextVC = [[DRCreditorBackViewController alloc] init];
//        nextVC.debetId = model.debetId;
//        nextVC.assetPackageId = model.debetId;
//        [nav.navigationController pushViewController:nextVC animated:YES];
//    } else if ([model.typeInfo isEqualToString:@"c"]) {
//        DRZhaiQuanCaseViewController *nextVC = [[DRZhaiQuanCaseViewController alloc] init];
//        nextVC.debetId = model.debetId?:@"";
//        nextVC.caseId = model.casesId?:@"";
//        nextVC.caseName = model.caseId?:@"";
//        [nav.navigationController pushViewController:nextVC animated:YES];
//    }
}

//iOS10 通知栏回调 接收的方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    completionHandler(UIBackgroundFetchResultNewData);
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [self postNotiMessageWithUserInfo:userInfo];
        
        [UMessage didReceiveRemoteNotification:userInfo];
       
        //这个方法用来做action点击的统计
        [UMessage sendClickReportForRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    [self incomePushMessage:userInfo];
}


- (void)postNotiMessageWithUserInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoNotification object:self userInfo:userInfo];
}



//获取device_Token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
    [UMessage setUniqueID:[FCUUID uuidForDevice]];
    NSString *dt = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dt forKey:@"deviceToken"];
//    NSLog(@"deviceToken === %@",dt);
    [defaults synchronize];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UMessage setAutoAlert:NO];
    //推送开关改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationState object:nil userInfo:nil];
}


- (void)toUpdateEngine {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:appVersion()?:@"" forKey:@"versionCode"];
//    [params setObject:@"iOS" forKey:@"channel"];
//    [[request new] updateVersionWithParams:params net:nil error:nil handleErrorCode:nil];
}

//表示应用进入active状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self toUpdateEngine];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

//设置通知
- (void)setupNotificationSettingsWithOptions:(NSDictionary *)launchOptions {
    //    获取权限
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    switch (settings.types) {
        case UIUserNotificationTypeNone: NSLog(@"None"); break;
        case UIUserNotificationTypeAlert: NSLog(@"Alert Notification"); break;
        case UIUserNotificationTypeBadge: NSLog(@"Badge Notification"); break;
        case UIUserNotificationTypeSound: NSLog(@"sound Notification'"); break; default: break;
    }
    
    
    //友盟推送

    [UMessage startWithAppkey:@"5a94b8e18f4a9d4934000099" launchOptions:launchOptions];
    
    [UMessage registerForRemoteNotifications];
    
    
    [UMessage setBadgeClear:NO];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    
    
    //高级功能加入
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
        /*ios10以上*/
        UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"打开" options:UNNotificationActionOptionForeground];
        
        UNTextInputNotificationAction *action2 = [UNTextInputNotificationAction actionWithIdentifier:@"action2" title:@"清除" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"textInputButtonTitle" textInputPlaceholder:@"textInputPlaceholder"];
        
        UNNotificationCategory *category1 = [UNNotificationCategory categoryWithIdentifier:@"Category1" actions:@[action2,action1]  intentIdentifiers:@[@"action1",@"action2"] options:UNNotificationCategoryOptionCustomDismissAction];
        
        UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"action3" title:@"查看" options:UNNotificationActionOptionForeground];
        
        UNNotificationAction *action4 = [UNNotificationAction actionWithIdentifier:@"action4" title:@"关闭" options:UNNotificationActionOptionAuthenticationRequired];
        
        UNNotificationCategory *category2 = [UNNotificationCategory categoryWithIdentifier:@"Category2" actions:@[action3,action4]  intentIdentifiers:@[@"action3",@"action4"] options:UNNotificationCategoryOptionCustomDismissAction];
        //注册
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category1,category2, nil]];
        
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"completionHandler");
        }];
        
    }else{
        /*ios10以下*/
        UIMutableUserNotificationAction * action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1";
        action1.title=@"查看";
        action1.activationMode = UIUserNotificationActivationModeForeground;
        action1.destructive = YES;
        
        UIMutableUserNotificationAction * action2 = [[UIMutableUserNotificationAction alloc] init];
        action2.identifier = @"action2";
        action2.title=@"关闭";
        action2.activationMode = UIUserNotificationActivationModeBackground;
        action1.activationMode = UIUserNotificationActivationModeForeground;
        action1.destructive = YES;
        
        UIMutableUserNotificationCategory * category1 = [[UIMutableUserNotificationCategory alloc] init];
        category1.identifier = @"Category1";
        [category1 setActions:@[action2,action1] forContext:(UIUserNotificationActionContextDefault)];
        //注册
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects: category1, nil]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
    }
    
    //推送注册
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    //
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo) {
        [self incomePushMessage:userInfo];
    }
}
@end
