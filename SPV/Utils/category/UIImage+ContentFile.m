//
//  UIImage+ContentFile.m
//  thrallplus
//
//  Created by HeJia on 2017/2/21.
//  Copyright © 2017年 HeJia. All rights reserved.
//

#import "UIImage+ContentFile.h"

@implementation UIImage (ContentFile)

+(NSString *)pathForImageName:(NSString *)name bundle:(NSBundle *)bundle{
    NSString *imgName = name;
    if([name hasSuffix:@".png"]){
        imgName = [name stringByReplacingOccurrencesOfString:@".png" withString:@""];
    }
    
    NSString *mainBundlePath = [bundle pathForResource:imgName ofType:@"png"];
    if(mainBundlePath == nil ){
        if([imgName hasSuffix:@"@2x"] || [imgName hasSuffix:@"@3x"]){
            return nil;
        }else{
            NSString* fullName = [NSString stringWithFormat:@"%@@%.0fx",imgName,[UIScreen mainScreen].scale];
            mainBundlePath = [bundle pathForResource:fullName ofType:@"png"];
            return mainBundlePath;
        }
    }else{
        return mainBundlePath;
    }
}

+(NSString *) pathForImageName:(NSString *)name{
    return [self pathForImageName:name bundle:[NSBundle mainBundle]];
}


+(UIImage *) exImageNamed:(NSString *) name{
    NSString *mainBundlePath = [self pathForImageName:name];
    if(mainBundlePath.length > 0){
        UIImage *image = [UIImage imageWithContentsOfFile:mainBundlePath];
        return image;
    }else{
        return nil;
    }
}



@end
