//
//  HJUserDefault.m
//  thrallplus
//
//  Created by HeJia on 16/6/22.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJUserDefault.h"

static NSUserDefaults *user_default(){
    return [NSUserDefaults standardUserDefaults];
}

@implementation HJUserDefault

+(void)setObject:(id)value forKey:(NSString *)key{
    assert(value != nil);
    [user_default() setObject:value forKey:key];
    bool saved = [user_default() synchronize];
    HJLog(@"save HJUserDefault success = %d  %@=%@",saved,key,value);
}

+(void) setObjects:(NSDictionary *)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [user_default() setObject:obj forKey:key];
        *stop = NO;
    }];
    [user_default() synchronize];
}

+(id) objectForKey:(NSString *)key{
    return [user_default() objectForKey:key];
}

+(NSArray<id> *) values:(NSArray *)keys{
    NSMutableArray *retAry = [NSMutableArray new];
    for(NSString *key in keys){
        [retAry addObject:[self objectForKey:key]];
    }
    return retAry;
}

+(void) clear{
    [NSUserDefaults resetStandardUserDefaults];
}

@end







@implementation HJUserDefault(Launch)

+(bool) isNeedShowGuidePage{
    NSNumber *number = [self objectForKey:_UD_NEED_SHOW_GUIDEPAGE_];
    if(number == nil) return YES;
    
    return [number boolValue];
}

+(bool) isNeedShowModifyInfo{
    NSNumber *number = [self objectForKey:_UD_NEED_SHOW_GUIDEPAGE_];
    if(number == nil) return YES;
    
    return [number boolValue];
}

+(void) setNeedShowGuidePage:(bool)b{
    return [self setObject:[NSNumber numberWithBool:b] forKey:_UD_NEED_SHOW_GUIDEPAGE_];
}

+(void) setNeedShowModifyInfo:(bool)b{
    return [self setObject:[NSNumber numberWithBool:b] forKey:_UD_NEED_SHOW_MODIFYINFO_];
}

@end
