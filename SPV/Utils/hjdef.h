//
//  hjdef.h
//  Hejiajinrong+
//
//  Created by HeJia on 16/5/3.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#ifndef hjdef_h
#define hjdef_h

#define __IPHONE_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) 

/**提测*/
//#define HTTPURL @"http://121.196.201.245:8082/"

/**开发 中权本地*/
//#define HTTPURL @"http://192.168.149.70:8080/"

/**预发布*/
//#define HTTPURL @"http://121.196.201.245:8081/"

/**正式*/
#define HTTPURL @"http://118.31.34.37:8080/"



//#define __userKey @"1c21df39-7728-4fd5-a840-63ff0182effc"


//#define UMAppKey @"5430d573fd98c521aa0380d9"
#define HJSecretKey @"%le&nvhZnEg@bp%oAo9gHA8x^fW8&Qd#kgjxeXbX@d13vmFv!mSkysd!8BW72R6M"
#define HJReferee @"iOS"


#endif /* hjdef_h */

