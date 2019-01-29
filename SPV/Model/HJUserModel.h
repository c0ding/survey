//
//  HJUserModel.h
//  thrallplus
//
//  Created by HeJia on 16/7/1.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJUserModel : NSObject

//@property (nonatomic,assign) NSUInteger createDate;
//@property (nonatomic,assign) NSUInteger external;
//@property (nonatomic,assign) bool       hasPassword;
//@property (nonatomic,assign) NSInteger  id;
//@property (nonatomic,copy  ) NSString   *ip;
@property (nonatomic,copy  ) NSString   *mobile;
//@property (nonatomic,assign) NSUInteger modifyDate;
//@property (nonatomic,copy  ) NSString   *openId;
//@property (nonatomic,copy  ) NSString   *protectedIdCard;
//@property (nonatomic,copy  ) NSString   *protectedMobile;
//@property (nonatomic,copy  ) NSString   *protectedRealName;
//@property (nonatomic,copy  ) NSString   *realName;
//@property (nonatomic,copy  ) NSString   *referee;
//@property (nonatomic,assign) NSInteger  refreshDate;
//@property (nonatomic,copy  ) NSString   *subReferee;
@property (nonatomic,copy  ) NSString   *userKey;
@property (nonatomic,copy  ) NSString   *headPic;
@property (nonatomic,copy  ) NSString   *userName;
@property(nonatomic,copy)NSString * userType;

@end



