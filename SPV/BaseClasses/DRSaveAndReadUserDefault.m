//
//  DRSaveAndReadUserDefault.m
//  SPV
//
//  Created by 黄梦炜 on 2017/12/7.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRSaveAndReadUserDefault.h"
static DRSaveAndReadUserDefault * _personData;
@implementation DRSaveAndReadUserDefault

+ (instancetype) getInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_personData == nil) {
            _personData = [[DRSaveAndReadUserDefault alloc] init];
            NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
            NSMutableArray *array = [NSMutableArray array];
            [userD setObject:array forKey:PersonHistoryKey];
        }
    });
    
    return _personData;
}


-(void)setDataInUserData:(NSString *)searchData
{
    NSMutableArray *array = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] arrayForKey:PersonHistoryKey];
    [array addObject:searchData];
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:array forKey:PersonHistoryKey];
}

-(NSArray *)getDataFromUserData
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:PersonHistoryKey];
    return array;
}


@end
