//
//  DRCollectSheetView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/18.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectSheetMainView.h"
#import "DRCollectSheetMainCell.h"
#define kItemHeight  kHeight(50)
#define kSectionHeight kHeight(40)
#define kMaxCount 7
@interface DRCollectSheetMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UIView *cover;
@property (nonatomic ,strong)DRBaseTableView *tableView;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat sheetHeight;
@end
@implementation DRCollectSheetMainView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
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
                         self.tableView.transform = CGAffineTransformMakeTranslation(0, -_sheetHeight);
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
                         self.tableView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)initUI {
    [self addSubview:({
        UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
        cover.backgroundColor = RGBA(0, 0, 0, 0.7);
        cover.alpha = 0;
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _cover = cover;
    })];
    
    
    _tableView = ({
        DRBaseTableView *view = [[DRBaseTableView alloc] init];
        view.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _offsetY);
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        view.sectionHeaderHeight = kSectionHeight;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
        view.rowHeight = kItemHeight;
        [self addSubview:view];
        view;
    });
}

- (void)setContents:(NSMutableArray<NSString *> *)contents {
    _contents = contents;
    
    _sheetHeight = contents.count >kMaxCount?kMaxCount* kItemHeight + kSectionHeight:
    contents.count * kItemHeight + kSectionHeight;
    
    _tableView.height = _sheetHeight;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DRCollectSheetMainCell *cell = [[DRCollectSheetMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = _contents[indexPath.row];
    
    cell.isSelect = indexPath.row == _currertSlectIndex;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview: label];
    label.text = _tittle;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(17)];
    label.textColor = [UIColor colorWithRed:38/255.0 green:35/255.0 blue:30/255.0 alpha:1/1.0];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _currertSlectIndex = indexPath.row;
    
    [self.tableView reloadData];
    //        [self dismiss];
    
    
    if (self.sheetMainBlock) {
        self.sheetMainBlock(_currertSlectIndex, _contents[_currertSlectIndex]);
    }

    
}


@end
