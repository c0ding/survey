//
//  DRRegisterNicknameView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/15.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DRRegisterNicknameViewDelegate <NSObject>
@optional
- (void)nextBtnClick;
@end
@interface DRRegisterNicknameView : UIView
@property (nonatomic ,strong) UITextField *nicknameText;
@property (nonatomic ,strong) UILabel *errorMsgLab;
@property (nonatomic ,weak)id <DRRegisterNicknameViewDelegate>delegate;
@end
