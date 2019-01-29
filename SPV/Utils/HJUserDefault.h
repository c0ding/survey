//
//  HJUserDefault.h
//  thrallplus
//
//  Created by HeJia on 16/6/22.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface HJUserDefault : NSObject

+(void) setObject:(id)value forKey:(NSString *)key;

+(void) setObjects:(NSDictionary*)dic;

+(id) objectForKey:(NSString *)key;

+(NSArray<id> *) values:(NSArray *)keys;

+(void) clear;

@end


#define _UD_NEED_SHOW_GUIDEPAGE_    @"_needshowguidepage_"
#define _UD_NEED_SHOW_MODIFYINFO_   @"_needshowmodifyinfo_"

@interface HJUserDefault(Launch)

+(void) setNeedShowGuidePage:(bool) b;

+(bool) isNeedShowGuidePage;

+(void) setNeedShowModifyInfo:(bool) b;

+(bool) isNeedShowModifyInfo;

@end
