//
//  DRKeyboardTextView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/20.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRKeyboardTextView.h"

#define kMaxTextViewH 80
@interface DRKeyboardTextView()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextViewH;//文字大于限定高度的状态
    NSString *placeholderText;//占位符
}
@property (nonatomic ,strong) UIView *backGroundView;
@property (nonatomic ,strong) UILabel *placeholderLabel;
@property (nonatomic ,strong) UIButton *sendBtn;
@end
@implementation DRKeyboardTextView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFrame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTapClick)];
        [self addGestureRecognizer:centerTap];
    }
    return self;
}
- (void)setupFrame{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(6);
        make.left.equalTo(self.backGroundView).offset(5);
        make.bottom.equalTo(self.backGroundView).offset(-6);
        make.width.offset(kScreenWidth - 65);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(5);
        make.left.equalTo(self.backGroundView).offset(10);
         make.height.offset(kHeight(39));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(8);
        make.right.equalTo(self.backGroundView).offset(-5);
        make.width.offset(50);
    }];
}
- (void)textViewDidChange:(UITextView *)textView {
    //设置占位符
    
    if (textView.text.length == 0) {
        self.placeholderLabel.text = placeholderText;
        [self.sendBtn setBackgroundColor:RGB(169, 169, 169)];
        self.sendBtn.userInteractionEnabled = NO;
    }else {
        self.placeholderLabel.text = nil;
        [self.sendBtn setBackgroundColor:[UIColor redColor]];
        self.sendBtn.userInteractionEnabled = YES;
    }
    
    CGSize size = CGSizeMake(kScreenWidth-65, CGFLOAT_MAX);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font(16)],NSFontAttributeName, nil];
   
    CGFloat currentH = [textView.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
    if (currentH <19.094) {
        statusTextViewH = NO;
        self.backGroundView.frame = CGRectMake(0, y-49, kScreenWidth, 49);
        
    }else if (currentH < kMaxTextViewH) {
        statusTextViewH = NO;
        self.backGroundView.frame = CGRectMake(0, y-textView.contentSize.height-10, kScreenWidth, textView.contentSize.height+10);
    }else {
        statusTextViewH = YES;
        return;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (statusTextViewH == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}
- (void)setPlaceholderText:(NSString *)text {
    placeholderText = text;
    self.placeholderLabel.text = text;
}
- (void)keyboardWillShow:(NSNotification *)noti {
    self.frame = [UIScreen mainScreen].bounds;
    
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, kScreenHeight-height-self.backGroundView.size.height, kScreenWidth, 49);
    }else {
        CGRect rect = CGRectMake(0, kScreenHeight-height-self.backGroundView.size.height, kScreenWidth, self.backGroundView.size.height);
        self.backGroundView.frame = rect;
        NSLog(@"键盘 will show");
    }
}
- (void)keyboardWillHide:(NSNotification *)noti {
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
    }else {
        CGRect rect = CGRectMake(0,0, kScreenWidth, self.backGroundView.size.height);
        self.backGroundView.frame = rect;
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.backGroundView.size.height);
    }
}

- (void)centerTapClick {
    [self.textView resignFirstResponder];
}

- (void)sendClick:(UIButton *)sender {
    [self.textView endEditing:YES];
    if (self.TextBlcok) {
        self.TextBlcok(self.textView.text);
    }
    
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
    [self.sendBtn setBackgroundColor:[UIColor blackColor]];
    self.sendBtn.userInteractionEnabled = NO;
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
    self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
}

- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
        _backGroundView.backgroundColor = RGB(230, 230, 230);
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:font(16)];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 5;
        _textView.keyboardType = UIKeyboardTypeASCIICapable;
        _textView.autocapitalizationType  =  UITextAutocorrectionTypeNo ;
        

        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = [UIFont systemFontOfSize:font(16)];
        _placeholderLabel.textColor = [UIColor redColor];
        [self.backGroundView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setBackgroundColor:RGB(180, 180, 180)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.layer.cornerRadius = 5;
        _sendBtn.userInteractionEnabled = NO;
        [self.backGroundView addSubview:_sendBtn];
    }
    return _sendBtn;
}
@end
