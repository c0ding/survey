//
//  DRDatePicker.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/20.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRDatePicker.h"
#define DateFormatDic(dateType) @{@0:@"yyyy-MM-dd",@1:@"yyyy-MM-dd HH:mm",@2:@"yyyy/MM/dd HH:mm:ss",@3:@"yyyy/MM/dd HH:mm EEE"}[dateType]

@interface DRDatePicker()
@property (nonatomic, weak) UIView *cover;
@property (strong, nonatomic) UIView *pickerConten;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *confirmBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIDatePicker *picker;
@end
@implementation DRDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self setupFrame];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLab.text = title;
}

- (void)initUI {
    [self addSubview:({
        UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
        cover.backgroundColor = RGBA(0, 0, 0, 0.7);
        cover.alpha = 0;
//        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _cover = cover;
    })];
    
    [_cover addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth(343), kHeight(343))];
        view.backgroundColor = [UIColor whiteColor];
        view.center = self.center;
        
        _pickerConten = view;
    })];
    
    [_pickerConten addSubview:({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(17)];
        label.textColor = [UIColor colorWithRed:38/255.0 green:35/255.0 blue:30/255.0 alpha:1/1.0];
        _titleLab  = label;
    })];
    
    
    
    _picker = ({
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        [_pickerConten addSubview:picker];
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [picker setDate:[NSDate date] animated:YES];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.backgroundColor = [UIColor whiteColor];
        picker;
    });
    _confirmBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pickerConten addSubview:btn];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(15)];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(242, 169, 73) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _cancelBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pickerConten addSubview:btn];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(15)];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}


- (void)confirm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *dateStr = [formatter  stringFromDate:_picker.date];
    if (self.dateChooseCallBack) {
        self.dateChooseCallBack(dateStr);
    }
    
    [self dismiss];
}
- (void)setupFrame {
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.top.offset(kHeight(16));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(86));
        make.height.offset(kHeight(53));
        make.bottom.offset(0);
        make.right.offset(0);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(86));
        make.height.offset(kHeight(53));
        make.bottom.offset(0);
        make.right.equalTo(_confirmBtn.mas_left).offset(0);
    }];
    
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kWidth(279));
        make.height.offset(kHeight(185));
        make.top.equalTo(_titleLab.mas_bottom).offset(kHeight(32));
        make.centerX.offset(0);
    }];
}
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 1.0;
                      
//                         self.tableView.transform = CGAffineTransformMakeTranslation(0, -_sheetHeight);
                     }
                     completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 0.0;
                         
//                         self.tableView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}@end
