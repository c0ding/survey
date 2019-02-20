//
//  DRLoginFormView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/12.
//  Copyright © 2019年 hejiahuan. All rights reserved.
//

#import "DRLoginFormView.h"

@interface DRLoginFormView()<UITextFieldDelegate>
@property (nonatomic ,strong) UILabel *lab;
@property (nonatomic ,strong) UIView *line1;
@property (nonatomic ,strong) UIView *line2;
@property (nonatomic ,strong) UITextField *text;

@end

@implementation DRLoginFormView

#pragma mark - 协议实现
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _line2.backgroundColor = RGB(242, 169, 73);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _line2.backgroundColor = RGB(169 , 169, 169);
}

#pragma mark - 事件传出
- (void)textChange:(UITextField *)textField {
    
    if (self.textChangeBlock) {
        self.textChangeBlock(textField.text);
    }
    

}

#pragma mark - 设置方法
- (void)setTitle:(NSString *)title {
    _lab.text = title;
}
- (void)setContent:(NSString *)content {
    _text.text = content;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _text.placeholder = placeholder;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _text.secureTextEntry = secureTextEntry;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}

- (void)initUI {
    _lab = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"";
        [self addSubview:label];
        label.frame = CGRectMake(24, 225, 45, 21);
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font(15)];
        label.textColor = [UIColor colorWithRed:38/255.0 green:35/255.0 blue:30/255.0 alpha:1/1.0];
        label;
    });
    
    _line1 = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1/1.0];
        view;
    });
    
    _text = ({
        UITextField * textView = [[UITextField alloc] init];
        textView.textAlignment = NSTextAlignmentLeft;
        [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        textView.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textView.delegate = self;
        [self addSubview:textView];
        textView;
    });
    
    _line2 = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1/1.0];
        view;
    });
}
- (void)setupFrame {
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(0);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.width.offset(0.5f);
        make.height.offset(kHeight(21));
        make.left.equalTo(_lab.mas_right).offset(kWidth(8));
    }];
    
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.height.offset(kHeight(21));
        make.width.offset(kWidth(270));
        make.left.equalTo(_lab.mas_right).offset(kWidth(16));
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.height.offset(0.5);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
