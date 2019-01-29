//
//  NSData+AES.h
//  thrallplus
//
//  Created by HeJia on 16/7/12.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  数据内容加密
 */
@interface NSData (AES)

- (NSData *)AES256Encrypt;

- (NSData *)AES256Decrypt;

@end
