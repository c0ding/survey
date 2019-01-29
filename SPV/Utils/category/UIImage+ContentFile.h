//
//  UIImage+ContentFile.h
//  thrallplus
//
//  Created by HeJia on 2017/2/21.
//  Copyright © 2017年 HeJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ContentFile)

+(UIImage *) exImageNamed:(NSString *)name;

+(NSString *)pathForImageName:(NSString *)name bundle:(NSBundle *)bundle;

+(NSString *)pathForImageName:(NSString *)name;

@end
