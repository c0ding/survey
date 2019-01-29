//
//  DRInviteCodeView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/11.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DRInviteCodeViewDelegate <NSObject>
@optional
- (void)nextBtnClick;
@end

@interface DRInviteCodeView : UIView
@property (nonatomic ,strong) UITextField *codeText;
@property (nonatomic ,strong) UILabel *errorMsgLab;
@property (nonatomic ,weak)id <DRInviteCodeViewDelegate>delegate;
@end
