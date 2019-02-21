//
//  DRKeyboardTextView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/20.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TextViewBlcok)(NSString *text);
@interface DRKeyboardTextView : UIView
/* 唤醒 */
@property (nonatomic,strong) UITextView *textView;
/*发送文本 */
@property (nonatomic,copy) TextViewBlcok TextBlcok;
/*设置占位符 */
-(void)setPlaceholderText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
