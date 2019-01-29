//
//  HJUser.m
//  thrallplus
//
//  Created by HeJia on 16/7/12.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJUser.h"
#import "NSObject+CryptFile.h"
#import "HJDataInterface.h"



static NSString * documentPath()
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [NSString stringWithFormat:@"%@/config",path];
    return path;
}

@implementation HJUser

SYNTHESIZE_SINGLETON_FOR_CLASS(HJUser);

-(instancetype)init{
    if(self = [super init]){
        //! 装载本地数据
        [self reload];
        
    }
    return self;
}

-(void) save{
    [self.user object2FileWithAes:documentPath()];
}

-(void) setUser:(HJUserModel *)user{
    _user = user;
    self.isLogin = [self _isLogin];
    
//    [HJUserDefault setObject:_user.mobile==nil?@"":_user.mobile forKey:@"usermobile"];
#ifdef __userKey
    updateCommparam(@"userKey",__userKey);
#else
    updateCommparam(@"userKey",_user.userKey);
#endif
    if([self isLogin]){
        
    }
}

-(void) reload{
    self.user = (HJUserModel *)[HJUserModel file2ObjectWithAse:documentPath()];
}

-(bool) _isLogin{
    return self.user == nil?NO:YES;
}

-(void)logout{
    
    [UMessage removeAlias:__user.user.userName type:kMoan response:^(id responseObject, NSError *error) {
    }];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    _user = nil;
    self.isLogin = NO;
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:documentPath() error:&error];
    [HJUserDefault clear];
    updateCommparam(@"userKey",@"");
}

-(NSString *)mobile{
    if(self.user != nil){
        return self.user.mobile;
    }else{
        return [HJUserDefault objectForKey:@"usermobile"];
    }
}
@end
