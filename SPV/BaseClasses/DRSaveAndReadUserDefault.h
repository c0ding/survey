//
//  DRSaveAndReadUserDefault.h
//  SPV
//
//  Created by 黄梦炜 on 2017/12/7.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PersonHistoryKey  @"userHistoryDataKey"
@interface DRSaveAndReadUserDefault : NSObject

+ (instancetype) getInstance;

-(void)setDataInUserData:(NSString *)searchData;
-(NSArray *)getDataFromUserData;
@end
