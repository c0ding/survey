//
//  DRPwdTextView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/22.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRPwdTextViewDelegate <NSObject>
@optional

- (void)pwdTextChangeWithValue:(BOOL)isShow;
@end

@interface DRPwdTextView : UIView
@property (nonatomic ,weak)id <DRPwdTextViewDelegate>delegate;
@property (nonatomic ,strong) UITextField *userText;
@property (nonatomic ,strong) UITextField *pwdText;
@property (nonatomic ,strong) UIView *usernameView;
@property (nonatomic ,strong) UIView *userLine;
@property (nonatomic ,strong) UIView *passwordView;
@property (nonatomic ,strong) UIView *pwdLine;
- (void)textChange;

@end
