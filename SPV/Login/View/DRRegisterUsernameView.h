//
//  DRRegisterUsernameView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/24.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRPwdTextView.h"
@protocol DRRegisterUsernameViewDelegate <NSObject>
@optional
- (void)nextBtnClick;
@end
@interface DRRegisterUsernameView : UIView
@property (nonatomic ,strong)DRPwdTextView *pwdTextView;
@property (nonatomic ,strong) UILabel *errorMsgLab;
@property (nonatomic ,weak)id <DRRegisterUsernameViewDelegate>delegate;
@end
