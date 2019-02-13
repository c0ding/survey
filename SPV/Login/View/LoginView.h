//
//  LoginView.h
//  SPV
//
//  Created by zyy on 2017/5/2.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginViewDelegate <NSObject>
@optional
- (void)loginViewLoginBtnClickWithUserName:(NSString *)userName andPwd:(NSString *)pwd;
@end


@interface LoginView : UIView
@property (nonatomic ,weak)id <LoginViewDelegate>delegate;
+ (instancetype)loginView;
@end
