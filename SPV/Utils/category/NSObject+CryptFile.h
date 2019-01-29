//
//  NSObject+CryptFile.h
//  thrallplus
//
//  Created by HeJia on 16/7/12.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  对象数据转为ase加密后的文件
 */
@interface NSObject (CryptFile)

-(void) object2FileWithAes:(NSString *) filePath;

+(NSObject *) file2ObjectWithAse:(NSString *) filePath;

+(NSArray<NSObject *> *)file2ObjectArrayWithAse:(NSString *)filePath;

@end
