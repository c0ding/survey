//
//  NSObject+CryptFile.m
//  thrallplus
//
//  Created by HeJia on 16/7/12.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "NSObject+CryptFile.h"
#import "MJExtension.h"
#import "NSData+AES.h"

@implementation NSObject (CryptFile)

+(NSObject *)file2ObjectWithAse:(NSString *)filePath{
    NSData *aesData = [NSData dataWithContentsOfFile:filePath];
    NSData *data = [aesData AES256Decrypt];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [[self class] mj_objectWithKeyValues:jsonString];
}

+(NSArray<NSObject *> *)file2ObjectArrayWithAse:(NSString *)filePath{
    NSData *aesData = [NSData dataWithContentsOfFile:filePath];
    NSData *data = [aesData AES256Decrypt];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [[self class] mj_objectArrayWithKeyValuesArray:jsonString];

}

-(void)object2FileWithAes:(NSString *)filePath{
    NSString *jsonString = [self mj_JSONString];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aseData = [data AES256Encrypt];
    bool b = [aseData writeToFile:filePath atomically:YES];
    HJLog(@"save user info %d",b);
}



@end
