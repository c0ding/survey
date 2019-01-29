//
//  HJUser.h
//  thrallplus
//
//  Created by HeJia on 16/7/12.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJUserModel.h"
#import "ARCSingletonTemplate.h"

@interface HJUser : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(HJUser)

//! 不允许修改，且不会保存
@property (nonatomic,strong) HJUserModel *user;

@property (nonatomic,assign) bool isLogin;

//! 先重用户登录数据中取手机号，如果取不到就到本地序列化数据中取，在未登录状态下，且用户之前登录过，能获取到手机号
@property (nonatomic,weak,readonly) NSString *mobile;

-(void) logout;

-(void) save;

-(void) reload;

//-(bool) isLogin;

@end


#define __user [HJUser sharedHJUser]
#define __userData [HJUser sharedHJUser].user

